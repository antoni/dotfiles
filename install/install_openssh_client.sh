#!/usr/bin/env bash

set -Eeuo pipefail

# shellcheck source=/dev/null
source "$HOME"/dotfiles/config.sh
# shellcheck source=/dev/null
source "$HOME"/dotfiles/utils.sh

MIN_OPENSSH_VERSION="${MIN_OPENSSH_VERSION:-9.9p1}"
OPENSSH_VERSION="${OPENSSH_VERSION:-10.4p1}"
OPENSSH_MIRROR="${OPENSSH_MIRROR:-https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable}"
OPENSSH_SHA256_BASE64="${OPENSSH_SHA256_BASE64:-}"
ALLOW_REMOVE_DEPENDENTS="${ALLOW_REMOVE_DEPENDENTS:-0}"
BUILD_ROOT="${BUILD_ROOT:-$HOME/tmp}"

CLIENT_BINARIES=(
	ssh
	scp
	sftp
	ssh-add
	ssh-agent
	ssh-keygen
	ssh-keyscan
)

CLIENT_HELPERS=(
	ssh-keysign
	ssh-pkcs11-helper
	ssh-sk-helper
)

function check_os() {
	[[ -r /etc/os-release ]] || {
		log_error "Cannot detect operating system"
		return 1
	}

	# shellcheck source=/dev/null
	source /etc/os-release

	case "${ID:-}" in
		debian | ubuntu) ;;
		*)
			log_error "Unsupported OS: ${ID:-unknown}"
			return 1
			;;
	esac
}

function extract_openssh_version() {
	sed -nE \
		's/.*OpenSSH[^_]*_([0-9]+\.[0-9]+p[0-9]+).*/\1/p' <<<"$1" |
		head -n 1
}

function extract_package_version() {
	sed -nE \
		's/^([0-9]+:)?([0-9]+\.[0-9]+p[0-9]+).*/\2/p' <<<"$1" |
		head -n 1
}

function version_at_least() {
	dpkg --compare-versions "$1" ge "$2"
}

function package_installed() {
	dpkg-query \
		-W \
		-f='${db:Status-Status}\n' \
		"$1" 2>/dev/null |
		grep -Fxq installed
}

function current_client_is_compliant() {
	local ssh_path
	local version_output
	local version

	ssh_path="$(command -v ssh 2>/dev/null || true)"
	[[ -n "$ssh_path" ]] || return 1

	version_output="$("$ssh_path" -V 2>&1 || true)"
	version="$(extract_openssh_version "$version_output")"

	[[ -n "$version" ]] || return 1
	version_at_least "$version" "$MIN_OPENSSH_VERSION" || return 1

	"$ssh_path" -Q kex 2>/dev/null |
		grep -Fxq mlkem768x25519-sha256
}

function apt_candidate() {
	apt-cache policy openssh-client |
		awk '/^[[:space:]]*Candidate:/ { print $2; exit }'
}

function apt_candidate_is_compliant() {
	local candidate="$1"
	local version

	[[ -n "$candidate" && "$candidate" != "(none)" ]] || return 1

	version="$(extract_package_version "$candidate")"

	[[ -n "$version" ]] &&
		version_at_least "$version" "$MIN_OPENSSH_VERSION"
}

function expected_checksum() {
	if [[ -n "$OPENSSH_SHA256_BASE64" ]]; then
		printf '%s\n' "$OPENSSH_SHA256_BASE64"
		return
	fi

	case "$OPENSSH_VERSION" in
		10.4p1)
			printf '%s\n' \
				'72Am3SrqjVYFljjV0yYpAsiSzrqfiDlYNeDQbT+2Mjg='
			;;
		*)
			log_error \
				"Set OPENSSH_SHA256_BASE64 for OpenSSH $OPENSSH_VERSION"
			return 1
			;;
	esac
}

function planned_removals() {
	LC_ALL=C apt-get --simulate remove openssh-client 2>/dev/null |
		awk '/^Remv / { print $2 }'
}

function remove_packaged_client() {
	local package
	local -a extra_packages=()

	package_installed openssh-client || return 0

	while read -r package; do
		[[ -z "$package" || "$package" == openssh-client ]] ||
			extra_packages+=("$package")
	done < <(planned_removals)

	if ((${#extra_packages[@]} > 0)) &&
		[[ "$ALLOW_REMOVE_DEPENDENTS" != 1 ]]; then
		log_error \
			"Removing openssh-client would also remove: ${extra_packages[*]}"
		log_error \
			"Set ALLOW_REMOVE_DEPENDENTS=1 to allow this"
		return 1
	fi

	sudo env DEBIAN_FRONTEND=noninteractive \
		apt-get -qq remove \
		--yes \
		--no-auto-remove \
		openssh-client
}

function remove_unmanaged_file() {
	local path="$1"

	[[ -e "$path" || -L "$path" ]] || return 0

	if ! dpkg-query -S "$path" &>/dev/null; then
		sudo rm -f -- "$path"
	fi
}

function remove_unmanaged_client() {
	local file

	for file in "${CLIENT_BINARIES[@]}"; do
		remove_unmanaged_file "/usr/local/bin/$file"
		remove_unmanaged_file "/usr/bin/$file"
	done

	remove_unmanaged_file "/usr/local/bin/ssh-copy-id"
	remove_unmanaged_file "/usr/bin/ssh-copy-id"

	for file in "${CLIENT_HELPERS[@]}"; do
		remove_unmanaged_file "/usr/local/libexec/openssh/$file"
		remove_unmanaged_file "/usr/lib/openssh/$file"
	done
}

function remove_existing_client() {
	if command -v ssh &>/dev/null ||
		package_installed openssh-client; then
		log_info "Removing existing OpenSSH client"
	fi

	remove_packaged_client
	remove_unmanaged_client
	hash -r
}

function install_from_apt() {
	remove_existing_client

	log_info "Installing OpenSSH client from APT"

	sudo env DEBIAN_FRONTEND=noninteractive \
		apt-get -qq install \
		--yes \
		--no-install-recommends \
		openssh-client
}

function install_build_dependencies() {
	sudo env DEBIAN_FRONTEND=noninteractive \
		apt-get -qq install \
		--yes \
		--no-install-recommends \
		build-essential \
		ca-certificates \
		curl \
		libedit-dev \
		libfido2-dev \
		libssl-dev \
		openssl \
		pkg-config \
		zlib1g-dev
}

function build_openssh() {
	local archive
	local source_dir
	local stage_dir
	local build_log
	local expected
	local actual

	archive="$BUILD_ROOT/openssh-$OPENSSH_VERSION.tar.gz"
	source_dir="$BUILD_ROOT/openssh-$OPENSSH_VERSION"
	stage_dir="$BUILD_ROOT/openssh-$OPENSSH_VERSION-stage"
	build_log="$BUILD_ROOT/openssh-$OPENSSH_VERSION-build.log"

	version_at_least "$OPENSSH_VERSION" "$MIN_OPENSSH_VERSION" || {
		log_error \
			"OpenSSH $OPENSSH_VERSION is older than $MIN_OPENSSH_VERSION"
		return 1
	}

	expected="$(expected_checksum)"

	mkdir -p "$BUILD_ROOT"
	rm -rf "$source_dir" "$stage_dir" "$build_log"

	log_info "Downloading OpenSSH $OPENSSH_VERSION"

	curl \
		--fail \
		--location \
		--proto '=https' \
		--silent \
		--show-error \
		--tlsv1.2 \
		--output "$archive" \
		"$OPENSSH_MIRROR/openssh-$OPENSSH_VERSION.tar.gz"

	actual="$(
		openssl dgst -sha256 -binary "$archive" |
			openssl base64 -A
	)"

	if [[ "$actual" != "$expected" ]]; then
		log_error "OpenSSH checksum verification failed"
		rm -f "$archive"
		return 1
	fi

	tar -xzf "$archive" -C "$BUILD_ROOT"
	mkdir -p "$stage_dir"

	pushd "$source_dir" &>/dev/null || return 1

	if ! {
		./configure \
			--prefix=/usr \
			--sysconfdir=/etc/ssh \
			--libexecdir=/usr/lib/openssh \
			--with-libedit &&
			make --silent --jobs="$(nproc)" &&
			make \
				--silent \
				DESTDIR="$stage_dir" \
				install-nokeys
	} >"$build_log" 2>&1; then
		popd &>/dev/null || true
		log_error "OpenSSH build failed"
		tail -n 30 "$build_log" >&2
		return 1
	fi

	popd &>/dev/null || return 1

	OPENSSH_SOURCE_DIR="$source_dir"
	OPENSSH_STAGE_DIR="$stage_dir"
}

function install_file() {
	local source="$1"
	local destination="$2"
	local mode="$3"

	[[ -f "$source" ]] || return 0

	sudo install \
		-d \
		-o root \
		-g root \
		-m 0755 \
		"$(dirname "$destination")"

	sudo install \
		-o root \
		-g root \
		-m "$mode" \
		"$source" \
		"$destination"
}

function install_staged_client() {
	local file

	for file in "${CLIENT_BINARIES[@]}"; do
		install_file \
			"$OPENSSH_STAGE_DIR/usr/bin/$file" \
			"/usr/bin/$file" \
			0755
	done

	for file in "${CLIENT_HELPERS[@]}"; do
		if [[ "$file" == ssh-keysign ]]; then
			install_file \
				"$OPENSSH_STAGE_DIR/usr/lib/openssh/$file" \
				"/usr/lib/openssh/$file" \
				4711
		else
			install_file \
				"$OPENSSH_STAGE_DIR/usr/lib/openssh/$file" \
				"/usr/lib/openssh/$file" \
				0755
		fi
	done

	install_file \
		"$OPENSSH_SOURCE_DIR/contrib/ssh-copy-id" \
		"/usr/bin/ssh-copy-id" \
		0755
}

function install_from_source() {
	log_info "Building OpenSSH $OPENSSH_VERSION"

	install_build_dependencies
	build_openssh
	remove_existing_client

	log_info "Installing OpenSSH client"

	install_staged_client
	hash -r
}

function verify_installation() {
	local ssh_path
	local version_output
	local version

	hash -r

	ssh_path="$(command -v ssh 2>/dev/null || true)"

	[[ -n "$ssh_path" ]] || {
		log_error "ssh was not installed"
		return 1
	}

	version_output="$("$ssh_path" -V 2>&1 || true)"
	version="$(extract_openssh_version "$version_output")"

	[[ -n "$version" ]] || {
		log_error "Could not detect installed OpenSSH version"
		return 1
	}

	version_at_least "$version" "$MIN_OPENSSH_VERSION" || {
		log_error \
			"Installed OpenSSH $version is older than $MIN_OPENSSH_VERSION"
		return 1
	}

	"$ssh_path" -Q kex 2>/dev/null |
		grep -Fxq mlkem768x25519-sha256 || {
		log_error "ML-KEM key exchange is not supported"
		return 1
	}

	log_info "$version_output"
	log_info "ML-KEM key exchange supported"
}

function install_openssh_client() {
	local candidate

	check_os

	if current_client_is_compliant; then
		log_info "OpenSSH client already satisfies requirements"
		return 0
	fi

	sudo -v
	sudo apt-get -qq update

	candidate="$(apt_candidate)"

	if apt_candidate_is_compliant "$candidate"; then
		install_from_apt
	else
		install_from_source
	fi

	verify_installation
}

function main() {
	if ! install_openssh_client; then
		log_error "Error installing OpenSSH client"
		return 1
	fi
}

main "$@"