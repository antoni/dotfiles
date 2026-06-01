#!/usr/bin/env bash

set -euo pipefail

readonly RUSTUP_HOME="${HOME}/.rustup"
readonly CARGO_HOME="${HOME}/.cargo"
readonly CARGO_ENV="${CARGO_HOME}/env"

# TODO: Confirm we use it in installation process
log_info() {
	printf '[INFO] %s\n' "$*"
}

log_warn() {
	printf '[WARN] %s\n' "$*" >&2
}

log_error() {
	printf '[ERROR] %s\n' "$*" >&2
}

require_command() {
	local cmd="$1"

	if ! command -v "$cmd" >/dev/null 2>&1; then
		log_error "Required command not found: ${cmd}"
		exit 1
	fi
}

remove_system_rust() {
	local rustc_path

	if ! command -v rustc >/dev/null 2>&1; then
		return
	fi

	rustc_path="$(command -v rustc)"

	# Rust installed via APT
	if command -v dpkg >/dev/null 2>&1 &&
		dpkg -S "$rustc_path" 2>/dev/null | grep -q '^rust'; then
		log_info "Removing Rust packages installed via APT"
		sudo apt-get remove --purge -y rustc cargo
	fi

	# Rust installed via Snap
	if command -v snap >/dev/null 2>&1 &&
		snap list 2>/dev/null | grep -q '^rust'; then
		log_info "Removing Rust packages installed via Snap"
		sudo snap remove rustup rustc cargo || true
	fi

	# Verify no system rustc remains
	if command -v rustc >/dev/null 2>&1; then
		rustc_path="$(command -v rustc)"

		if [[ "$rustc_path" != "$CARGO_HOME/bin/rustc" ]]; then
			log_error "Conflicting system Rust installation detected: ${rustc_path}"
			log_error "Remove the installation manually and rerun this script."
			exit 1
		fi
	fi
}

install_rustup() {
	if command -v rustup >/dev/null 2>&1; then
		return
	fi

	require_command curl

	log_info "Installing rustup"

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
		sh -s -- -y

	# shellcheck disable=SC1090
	source "$CARGO_ENV"
}

load_rust_environment() {
	if [[ ! -f "$CARGO_ENV" ]]; then
		log_error "Rust environment file not found: $CARGO_ENV"
		exit 1
	fi

	# shellcheck disable=SC1090
	source "$CARGO_ENV"
}

ensure_toolchain() {
	if ! rustup show active-toolchain >/dev/null 2>&1; then
		log_info "Configuring default Rust toolchain: stable"
		rustup default stable
	fi
}

update_rust() {
	log_info "Updating Rust stable toolchain"
	rustup update stable
}

show_versions() {
	log_info "Installed toolchain versions"

	rustc --version
	cargo --version
	rustup --version
}

main() {
	log_info "Checking for conflicting system Rust installations"

	remove_system_rust
	install_rustup
	load_rust_environment
	ensure_toolchain
	update_rust

	log_info "Rust setup completed successfully"
	show_versions
}

main "$@"
