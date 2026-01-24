#!/usr/bin/env bash
set -e

# Installer for ODAFileConverter (Debian-based Linux & macOS)
# Downloads via curl -L and installs.
# Requires sudo (checked at the beginning).

# Update these URLs to the latest version if needed
DEB_URL="https://www.opendesign.com/guestfiles/get?filename=ODAFileConverter_QT6_lnxX64_8.3dll_26.8.deb"
DMG_URL="https://www.opendesign.com/guestfiles/get?filename=ODAFileConverter_QT6_macosx_8.3dll_26.8.dmg"

DEB_FILE="ODAFileConverter.deb"
DMG_FILE="ODAFileConverter.dmg"

require_sudo() {
	echo "[*] Checking sudo access..."
	if ! sudo -v; then
		echo "[!] Sudo privileges are required. Exiting."
		exit 1
	fi
}

download_file() {
	local url="$1"
	local out="$2"
	echo "[*] Downloading $out ..."
	curl -L -o "$out" "$url"

	# crude check: file must be at least ~1 MB
	local size
	size=$(stat -c%s "$out" 2>/dev/null || stat -f%z "$out")
	if [ "$size" -lt 1000000 ]; then
		echo "[!] Downloaded file is suspiciously small ($size bytes)."
		echo "    Likely an HTML page, not the real package."
		echo "    Please download manually from:"
		echo "    https://www.opendesign.com/guestfiles/oda_file_converter"
		exit 1
	fi
}

install_debian() {
	download_file "$DEB_URL" "$DEB_FILE"
	echo "[*] Installing $DEB_FILE ..."
	sudo apt install -y "./$DEB_FILE" || {
		sudo dpkg -i "$DEB_FILE"
		sudo apt-get -f install -y
	}

	# Fix libxcb-util symlink if missing
	if [ ! -e /usr/lib/x86_64-linux-gnu/libxcb-util.so.0 ] &&
		[ -e /usr/lib/x86_64-linux-gnu/libxcb-util.so.1 ]; then
		echo "[*] Fixing libxcb-util symlink..."
		sudo ln -s /usr/lib/x86_64-linux-gnu/libxcb-util.so.1 \
			/usr/lib/x86_64-linux-gnu/libxcb-util.so.0
	fi

	echo "[✓] Installed. Run with: ODAFileConverter"
}

install_macos() {
	download_file "$DMG_URL" "$DMG_FILE"
	echo "[*] Mounting $DMG_FILE ..."
	hdiutil attach "$DMG_FILE"

	local pkg_path
	pkg_path=$(ls /Volumes/ODAFileConverter*/ODAFileConverter*.pkg | head -n 1 || true)
	if [ -z "$pkg_path" ]; then
		echo "[!] Could not locate .pkg inside DMG."
		hdiutil detach /Volumes/ODAFileConverter* || true
		exit 1
	fi

	echo "[*] Installing $pkg_path ..."
	sudo installer -pkg "$pkg_path" -target /
	hdiutil detach /Volumes/ODAFileConverter*

	echo "[✓] Installed. Launch ODAFileConverter from Applications."
}

main() {
	require_sudo

	if command -v apt >/dev/null 2>&1; then
		install_debian
	elif [[ "$OSTYPE" == darwin* ]]; then
		install_macos
	else
		echo "[!] Unsupported OS. This script only supports Debian-based Linux and macOS."
		exit 1
	fi
}

main "$@"
