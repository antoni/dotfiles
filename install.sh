#!/usr/bin/env bash
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/antoni/dotfiles/master/install.sh)"
# or via wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/antoni/dotfiles/master/install.sh)"
# or via fetch:
#   sh -c "$(fetch -o - https://raw.githubusercontent.com/antoni/dotfiles/master/install.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/antoni/dotfiles/master/install.sh
#   sh install.sh

set -e

function copy_to_clipboard() {
	# TODO: Make it work on other OSes
	clip.exe
}

function generate_ssh_key() {
	FILE=~/.ssh/id_rsa.pub

	if [ -f "$FILE" ]; then
		printf "%s exists. Using existing one\n" "$FILE"
	else
		printf "Generating new %s\n" "$FILE"
		ssh-keygen -q -t rsa -N '' <<<$'\ny' >/dev/null 2>&1
	fi
}

function copy_ssh_key_to_clipboard() {
	copy_to_clipboard <~/.ssh/id_rsa.pub
	printf "SSH key pasted to clipboard. Please open this page on GitHub and paste the key there:\n
https://github.com/settings/keys\n"

}

function install_everything() {
	echo "Cloning dotfiles repository..."

	git clone git@github.com:antoni/dotfiles.git

	pushd dotfiles

	./install/install.sh

	popd
}

function clone_dotfiles() {
	read -p "Continue [y]/n: " -n 1 -r choice

	case "$choice" in
	y | Y)

		install_everything

		return
		;;

	n | N) exit 1 ;;
	*)
		install_everything

		return
		;;
	esac
}

function main() {
	generate_ssh_key

	copy_ssh_key_to_clipboard

	clone_dotfiles
}

main "$@"
