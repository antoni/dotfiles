#!/usr/bin/env bash

set -e

error_exit() {
  echo "Error: $1" >&2
  exit 1
}

TMP_DIR="$HOME/tmp"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$TMP_DIR" "$BIN_DIR" || error_exit "Failed to create directories"
cd "$TMP_DIR" || error_exit "Failed to enter temp directory"

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y curl unzip

echo "Downloading Bitwarden CLI..."
curl -Lso bw.zip "https://vault.bitwarden.com/download/?app=cli&platform=linux"

echo "Installing Bitwarden CLI..."
unzip -o bw.zip -d "$BIN_DIR"
chmod +x "$BIN_DIR/bw"

rm -f bw.zip

if ! grep -q "$BIN_DIR" <<< "$PATH"; then
  echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
fi

if command -v bw >/dev/null 2>&1; then
  echo "Installed: $(bw --version)"
else
  error_exit "Bitwarden CLI installation failed"
fi

rm -rf "$TMP_DIR"