#!/usr/bin/env bash
set -e

source "$HOME"/dotfiles/utils.sh

function main() {
	# On macOS, Chrome is installed via Homebrew
	if [[ "$UNAME_OUTPUT" == 'Darwin' ]]; then
		return
	fi

	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	sudo apt-get update
	sudo apt-get install --assume-yes google-chrome-stable
}

main "$@"
