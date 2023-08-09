#!/usr/bin/env bash
set -ue

# Aliases and custom functions
source "$HOME"/dotfiles/colors.sh
source "$HOME"/dotfiles/utils.sh

function update_pip_packages() {
	DISPLAY="" pip3 list --outdated | awk '{print $1}' | tail -n +3 |
		DISPLAY="" xargs -I % sh -c 'pip3 install --upgrade %'
}

function upgrade_apt_packages() {
	echo "Upgrading apt packages..."

	if [[ -n "$IS_WSL" ]]; then
		sudo hwclock --hctosys
	fi

	# https://askubuntu.com/a/668859/342465
	sudo apt-get update -qq -o=Dpkg::Use-Pty=0 &&
		sudo apt-get upgrade -qq -o=Dpkg::Use-Pty=0 --assume-yes

	sudo apt autoremove --assume-yes
}

function update_all() {
	pushd ~ &>/dev/null || exit # to correctly update global NPM packages

	if [[ "$UNAME_OUTPUT" == 'Darwin' ]]; then
		# This sometimes breaks Homebrew taps upgrade
		# update_xcode

		# echo "Updating macOS (if updates available)"
		# softwareupdate -i -a

		"$DOTFILES_DIR"/mac/post_install.sh

		# Do the rest without sudo
		sudo --reset-timestamp
	fi

	# WSL 2
	if test -f /proc/sys/kernel/osrelease && grep -q microsoft /proc/sys/kernel/osrelease; then
		echo "Updating WSL..."
		wsl.exe --update

		# https://askubuntu.com/a/1169203/342465
		sudo hwclock --hctosys

		# Run it first as it requires sudo
		upgrade_apt_packages

		echo "Upgrading WSL packages..."
		# Close VS Code beforehand (winget will request to close it via GUI otherwise)
		taskkill.exe /IM Code.exe

		winget.exe upgrade --all --include-unknown

		# Delete all links on Desktop: current user
		rm -rf /mnt/c/Users/"${WINDOWS_USERNAME}"/Desktop/*.{lnk,url}

		# Delete all links on Desktop: all users
		# [Environment]::GetFolderPath('CommonDesktopDirectory')
		rm -rf /mnt/c/Users/Public/Desktop/*.{lnk,url}
	fi

	source "${BASH_SOURCE%/*}/install/update_oh_my_zsh.sh"

	echo "Upgrading Vim plugins..."
	vim -i NONE -c PlugUpdate -c quitall &>/dev/null

	echo "Upgrading npm packages..."
	# The following command sometimes doesn't work:
	# npx npm-check --global --update-all
	# So instead we remove all the packages and do a fresh install:
	rm -rf .npm-global_packages

	source "${BASH_SOURCE%/*}/install/install_global_javascript_npm_packages.sh"
	install_global_javascript_npm_packages
	npm install --no-fund --no-progress --silent --quiet npm

	echo "Upgrading PIP packages..."
	# pip3 install --upgrade pip --user;
	# Running it twice seems to resolve some dependency issues which PIP reports when running it just one time
	update_pip_packages
	update_pip_packages

	# update_packages_mac

	popd &>/dev/null || exit

	printf "Upgrading all applications on %s\n" "$(date)" >>~/update_log.txt
	# rm -f ~/package.json
}

update_all
