#!/usr/bin/env bash
set -e

source "$HOME"/dotfiles/utils.sh

function main() {
	# On macOS, Chrome is installed via Homebrew
	if [[ "$UNAME_OUTPUT" == 'Darwin' ]]; then
		return
	fi

	# Ensure required tools exist
	sudo apt-get update
	sudo apt-get install --assume-yes wget gpg

	# Create keyring directory if needed
	sudo install -m 0755 -d /etc/apt/keyrings

	# Download and install Google’s signing key
	wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub |
		gpg --dearmor |
		sudo tee /etc/apt/keyrings/google-chrome.gpg >/dev/null

	# Add Chrome repository (idempotent)
	echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" |
		sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null

	# Install Chrome
	sudo apt-get update
	sudo apt-get install --assume-yes google-chrome-stable
}

main "$@"
