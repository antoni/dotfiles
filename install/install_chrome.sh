#!/usr/bin/env bash
set -ue

function main() {
	# On macOS, Chrome is installed via Homebrew

	# TODO Fedora check
	function install_fedora_chrome() {
		wget https://dl-ssl.google.com/linux/linux_signing_key.pub
		sudo rpm --import linux_signing_key.pub
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
		sudo rpm -i google-chrome-stable_current_x86_64.rpm
	}

	# TODO Debian/Ubuntu check
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	sudo apt-get update
	sudo apt-get install --assume-yes google-chrome-stable
}

main "$@"
