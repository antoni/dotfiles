#!/usr/bin/env bash
# Install Tailscale on recent Ubuntu/Debian (Ubuntu: focal/jammy/noble; Debian: bullseye/bookworm/trixie)
# Optional: export TAILSCALE_AUTHKEY="tskey-..."; export TAILSCALE_UP_FLAGS="--ssh --accept-dns=false" etc.

set -euo pipefail

log() { printf "\033[1;34m[+] %s\033[0m\n" "$*"; }
warn() { printf "\033[1;33m[!] %s\033[0m\n" "$*"; }
err() { printf "\033[1;31m[✗] %s\033[0m\n" "$*"; }

# sudo helper (works whether run as root or not)
if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
	SUDO="sudo"
else
	SUDO=""
fi

if ! command -v apt-get >/dev/null 2>&1; then
	err "This script supports apt-based systems (Debian/Ubuntu) only."
	exit 1
fi

# Ensure curl and ca-certificates for HTTPS fetches
if ! command -v curl >/dev/null 2>&1; then
	log "Installing prerequisites (curl, ca-certificates)..."
	DEBIAN_FRONTEND=noninteractive $SUDO apt-get update -y
	DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y curl ca-certificates
fi

# Read OS data
source /etc/os-release

OS_ID="${ID:-}"
OS_ID_LIKE="${ID_LIKE:-}"
VER_CODENAME="${VERSION_CODENAME:-}"
UBU_CODENAME="${UBUNTU_CODENAME:-}"
VER_ID="${VERSION_ID:-}"

# Try lsb_release as a fallback (sometimes useful on derivatives)
if [[ -z "$VER_CODENAME" || "$VER_CODENAME" == "n/a" ]]; then
	if command -v lsb_release >/dev/null 2>&1; then
		VER_CODENAME="$(lsb_release -cs || true)"
	fi
fi

# Prefer Ubuntu codename for Ubuntu/derivatives that expose it
if [[ "${OS_ID}" == "ubuntu" || "${OS_ID_LIKE}" == *"ubuntu"* ]]; then
	CODENAME="${UBU_CODENAME:-$VER_CODENAME}"
else
	CODENAME="$VER_CODENAME"
fi

# Map known version IDs to codenames if still missing/ambiguous
map_codename() {
	local os="$1" ver_id="$2" current="$3"
	if [[ -n "$current" && "$current" != "n/a" ]]; then
		printf '%s' "$current"
		return 0
	fi
	case "$os" in
	ubuntu)
		case "$ver_id" in
		24.04) echo "noble" ;;
		22.04) echo "jammy" ;;
		20.04) echo "focal" ;;
		*) echo "" ;;
		esac
		;;
	debian)
		case "$ver_id" in
		13 | 13.*) echo "trixie" ;;
		12 | 12.*) echo "bookworm" ;;
		11 | 11.*) echo "bullseye" ;;
		*) echo "" ;;
		esac
		;;
	*)
		echo ""
		;;
	esac
}

# Normalize OS family and codename
if [[ "$OS_ID" == "ubuntu" || "$OS_ID_LIKE" == *"ubuntu"* ]]; then
	FAMILY="ubuntu"
elif [[ "$OS_ID" == "debian" || "$OS_ID_LIKE" == *"debian"* ]]; then
	FAMILY="debian"
else
	err "Unsupported distro (ID=${OS_ID}, ID_LIKE=${OS_ID_LIKE}). Only Ubuntu/Debian (and close derivatives) are supported."
	exit 1
fi

CODENAME="$(map_codename "$FAMILY" "$VER_ID" "$CODENAME")"

if [[ -z "$CODENAME" || "$CODENAME" == "n/a" ]]; then
	err "Could not determine a supported codename for this system."
	err "Detected: FAMILY=${FAMILY}, VERSION_ID=${VER_ID}, VERSION_CODENAME=${VER_CODENAME}, UBUNTU_CODENAME=${UBU_CODENAME}"
	exit 1
fi

# Validate supported codenames (adjust as needed if your fleet includes others)
case "$FAMILY:$CODENAME" in
ubuntu:focal | ubuntu:jammy | ubuntu:noble | debian:bullseye | debian:bookworm | debian:trixie) ;;
*)
	warn "Codename '${CODENAME}' isn't in the tested list. Proceeding anyway; your mileage may vary."
	;;
esac

BASE_URL="https://pkgs.tailscale.com/stable"
KEY_URL="${BASE_URL}/${FAMILY}/${CODENAME}.noarmor.gpg"
LIST_URL="${BASE_URL}/${FAMILY}/${CODENAME}.tailscale-keyring.list"

log "Distro: $PRETTY_NAME"
log "Family: $FAMILY  Codename: $CODENAME"
log "Adding Tailscale apt repository..."

$SUDO mkdir -p /usr/share/keyrings /etc/apt/sources.list.d

# Fetch key and list files atomically to temp then move
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fsSL "$KEY_URL" -o "$TMP_DIR/tailscale-archive-keyring.gpg"
curl -fsSL "$LIST_URL" -o "$TMP_DIR/tailscale.list"

$SUDO install -m 0644 "$TMP_DIR/tailscale-archive-keyring.gpg" /usr/share/keyrings/tailscale-archive-keyring.gpg
$SUDO install -m 0644 "$TMP_DIR/tailscale.list" /etc/apt/sources.list.d/tailscale.list

log "Updating apt metadata and installing Tailscale..."
DEBIAN_FRONTEND=noninteractive $SUDO apt-get update -y
DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y tailscale

# Enable and start tailscaled where systemd is available
if command -v systemctl >/dev/null 2>&1; then
	log "Enabling and starting tailscaled..."
	$SUDO systemctl enable --now tailscaled
else
	warn "systemctl not found; ensure tailscaled is running via your init system."
fi

# Optionally bring the node up if an auth key is provided
if [[ "${TAILSCALE_AUTHKEY:-}" != "" ]]; then
	log "Bringing Tailscale up with provided auth key..."
	# shellcheck disable=SC2086
	$SUDO tailscale up --authkey="$TAILSCALE_AUTHKEY" ${TAILSCALE_UP_FLAGS:-}
	log "Tailscale is up. IPs:"
	tailscale ip || true
else
	printf "\nNext step:\n  sudo tailscale up\n\n"
	printf "Tip: to automate login, set TAILSCALE_AUTHKEY and (optionally) TAILSCALE_UP_FLAGS, e.g.:\n"
	printf "  TAILSCALE_AUTHKEY=tskey-xxxxx TAILSCALE_UP_FLAGS='--ssh --accept-routes' %s\n\n" "$0"
fi

log "Done."
