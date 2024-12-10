#!/usr/bin/env bash

set -e

source "$HOME"/dotfiles/config.sh
source "$HOME"/dotfiles/utils.sh

function main() {
	sudo apt install software-properties-common -y
	sudo add-apt-repository ppa:deadsnakes/ppa -y
	sudo apt update
	sudo apt install -y python3.12

	curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
	sudo update-alternatives --install /usr/bin/python3 python3 /bin/python3.12 2

	sudo update-alternatives --set python3 /bin/python3.12

	# pipx
	sudo apt update
	sudo apt install -y pipx
	pipx ensurepath
	sudo apt install -y python3.12-venv

	# Poetry
	pipx install poetry

	# Reinstall Python version-related pip packages
	sudo apt list --installed | grep 'python3.12' | cut -d'/' -f1 |
		xargs -o sudo apt autoremove -y && sudo apt install -y python3.12-full

	sudo apt-get install -y python3.12-dev

	sudo apt-get remove -y --purge python3-apt &&
		sudo apt-get install -y python3-apt
}

main "$@"
