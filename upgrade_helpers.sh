#!/usr/bin/env bash
source "$HOME"/dotfiles/colors.sh

function upgrade_npm_packages() {
	source "$HOME"/dotfiles/install/install_global_javascript_npm_packages.sh
	install_global_javascript_npm_packages
	npm install --no-fund --no-progress --silent --quiet npm
}

function upgrade_pip_packages() {
	DISPLAY="" pip3 list --outdated | awk '{print $1}' | tail --lines=+3 |
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

function upgrade_packages_mac() {
	# Skip this step for now, downloading >10 GBs of XCode every now and
	# then takes a lot of time and
	# doesn't really make an improvement
	# echo "Updating Mac AppStore packages..."
	# mas upgrade;

	echo "Upgrading Homebrew packages..."
	echo "Running 'brew cleanup'"
	brew cleanup

	# Fix casks with `depends_on` that reference pre-Mavericks
	/usr/bin/find "$(brew --prefix)/Caskroom/"*'/.metadata' -type f -name '*.rb' -print0 | /usr/bin/xargs -0 /usr/bin/sed -i '' '/depends_on macos:/d'

	# Somtimes needed to run before 'brew update'/'brew upgrade'
	brew tap --repair
	brew update
	brew upgrade
	brew upgrade --cask --force
	brew unlink node && brew link --overwrite node
	# Temporary overwrite for Node 16
	brew link --force --overwrite node@16
}

function upgrade_packages_fedora() {
	sudo dnf --assumeyes update
	sudo dnf --assumeyes autoremove
}

function upgrade_packages_ubuntu() {
	echo "Updating apt packages..."
	sudo apt-get update &>/dev/null
	echo "Upgrading apt packages..."
	sudo apt-get upgrade --assume-yes &>/dev/null
	echo "Autoremoving apt packages..."
	sudo apt-get autoremove &>/dev/null
}

function upgrade_xcode() {
	sudo rm --recursive --force /Library/Developer/CommandLineTools
	xcode-select --install
}
