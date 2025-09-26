#!/usr/bin/env bash
set -e

# Aliases and custom functions
source "$HOME"/dotfiles/colors.sh
source "$HOME"/dotfiles/utils.sh

function check_and_update_windows_subsystem_for_linux() {
	echo "Checking Windows Subsystem for Linux status..."
	local update_command_output
	update_command_output=$(wsl.exe --update 2>&1)

	if echo "$update_command_output" | grep -qi "up to date"; then
		echo "✅ Windows Subsystem for Linux is already up to date."
	else
		echo "⚡ Updating Windows Subsystem for Linux..."
		echo "$update_command_output"
		if wsl.exe --update; then
			echo "🎉 Windows Subsystem for Linux update completed successfully."
		else
			echo "❌ Windows Subsystem for Linux update failed." >&2
			return 1
		fi
	fi
}

function upgrade_all() {
	export DEBIAN_FRONTEND=noninteractive

	pushd ~ &>/dev/null || exit # to correctly update global NPM packages

	# macOS
	if [[ "$UNAME_OUTPUT" == 'Darwin' ]]; then
		# This sometimes breaks Homebrew taps upgrade
		# upgrade_xcode

		# echo "Updating macOS (if updates available)"
		# softwareupdate -i -a
		upgrade_packages_mac

		# Do the rest without sudo
		sudo --reset-timestamp
	fi

	# WSL 2
	if test -f /proc/sys/kernel/osrelease &&
		grep -q microsoft /proc/sys/kernel/osrelease; then

		trap delete_desktop_symlinks ERR
		trap delete_desktop_symlinks EXIT

		function delete_desktop_symlinks() {
			printf "Removing desktop symlinks/shortcuts\n"

			# Delete all links on Desktop: current user
			rm --recursive --force /mnt/c/Users/"${WINDOWS_USERNAME}"/Desktop/*.{lnk,url}

			# Delete all links on Desktop: all users
			# [Environment]::GetFolderPath('CommonDesktopDirectory')
			rm --recursive --force /mnt/c/Users/Public/{desktop,Desktop}/*.{lnk,url}
		}

		check_and_update_windows_subsystem_for_linux

		# Run it first as it requires sudo
		upgrade_apt_packages

		echo "Upgrading WSL packages..."
		# Close Visual Studio Code beforehand (winget will request to close it via GUI otherwise)
		if tasklist.exe | grep Code.exe; then
			taskkill.exe /F /IM Code.exe
		fi

		exec_powershell_script ~/dotfiles/windows/UpgradeWingetPackages.ps1
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

	upgrade_npm_packages

	echo "Upgrading PIP packages..."
	# Running it twice seems to resolve some dependency issues which PIP reports when running it just one time
	upgrade_pipx_packages
	upgrade_pipx_packages

	popd &>/dev/null || exit

	# macOS
	if [[ "$UNAME_OUTPUT" == 'Darwin' ]]; then
		"$HOME"/dotfiles/mac/post_install.sh

		# Do the rest without sudo
		sudo --reset-timestamp
	fi

	printf "Upgraded all applications on %s\n" "$(date)" >>~/update_log.txt
}

upgrade_all
