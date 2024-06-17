#!/usr/bin/env bash
set -e

# Aliases and custom functions
source "$HOME"/dotfiles/colors.sh
source "$HOME"/dotfiles/utils.sh

function upgrade_pip_packages() {
	DISPLAY="" pip3 list --outdated | awk '{print $1}' | tail -n +3 |
		DISPLAY="" xargs -I % sh -c 'pip3 install --upgrade %'
}

function upgrade_apt_packages() {
	echo "Upgrading apt packages..."

	# https://askubuntu.com/a/1169203/342465
	if [[ -n "$IS_WSL" ]]; then
		sudo hwclock --hctosys
	fi

	# https://askubuntu.com/a/668859/342465
	sudo apt-get update -qq -o=Dpkg::Use-Pty=0 &&
		sudo apt-get upgrade -qq -o=Dpkg::Use-Pty=0 --assume-yes

	sudo apt autoremove --assume-yes
}

function upgrade_all() {
	export DEBIAN_FRONTEND=noninteractive

	pushd ~ &>/dev/null || exit # to correctly update global NPM packages

	# macOS
	if [[ "$UNAME_OUTPUT" == 'Darwin' ]]; then
		# This sometimes breaks Homebrew taps upgrade
		# update_xcode

		# echo "Updating macOS (if updates available)"
		# softwareupdate -i -a
		update_packages_mac

		# Do the rest without sudo
		sudo --reset-timestamp
	fi

	# WSL 2
	if test -f /proc/sys/kernel/osrelease &&
		grep -q microsoft /proc/sys/kernel/osrelease; then

		set -Ee

		trap delete_desktop_symlinks ERR
		trap delete_desktop_symlinks EXIT

		function delete_desktop_symlinks() {
			printf "Removing desktop symlinks/shortcuts\n"

			# Delete all links on Desktop: current user
			rm --recursive --force /mnt/c/Users/"${WINDOWS_USERNAME}"/Desktop/*.{lnk,url}

			# Delete all links on Desktop: all users
			# [Environment]::GetFolderPath('CommonDesktopDirectory')
			rm --recursive --force /mnt/c/Users/Public/{desktop,Desktop}/*.{lnk,url}

			set +Ee
		}

		echo "Updating WSL..."
		wsl.exe --update

		# Run it first as it requires sudo
		upgrade_apt_packages

		echo "Upgrading WSL packages..."
		# Close Visual Studio Code beforehand (winget will request to close it via GUI otherwise)
		if tasklist.exe | grep Code.exe; then
			taskkill.exe /F /IM Code.exe
		fi

		winget.exe upgrade --all \
			--include-unknown \
			--accept-package-agreements \
			--accept-source-agreements
	fi

	echo "Upgrading oh-my-zsh..."
	source "$HOME"/dotfiles/install/update_oh_my_zsh.sh

	echo "Upgrading Vim plugins..."
	vim -i NONE -c PlugUpdate -c quitall &>/dev/null

	echo "Upgrading npm packages..."
	# The following command sometimes doesn't work:
	# npx npm-check --global --update-all
	# So instead we remove all the packages and do a fresh install:
	source "$HOME"/dotfiles/paths
	rm --recursive --force "$NPM_GLOBAL_PACKAGES_DIRECTORY"

	source "$HOME"/dotfiles/install/install_global_javascript_npm_packages.sh
	install_global_javascript_npm_packages
	npm install --no-fund --no-progress --silent --quiet npm

	echo "Upgrading PIP packages..."
	# Running it twice seems to resolve some dependency issues which PIP reports when running it just one time
	upgrade_pip_packages
	upgrade_pip_packages

	popd &>/dev/null || exit

	# macOS
	if [[ "$UNAME_OUTPUT" == 'Darwin' ]]; then
		"$DOTFILES_DIR"/mac/post_install.sh

		# Do the rest without sudo
		sudo --reset-timestamp
	fi

	printf "Upgraded all applications on %s\n" "$(date)" >>~/update_log.txt
}

upgrade_all
