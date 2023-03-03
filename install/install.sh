#!/usr/bin/env bash
set -ue

DOTFILES_DIR="$HOME"/dotfiles

mkdir -p tmp

# TODO: Fixme
# source "$DOTFILES_DIR"/install/chrome_install.sh
source "$DOTFILES_DIR"/mac/brew_install.sh
source "$DOTFILES_DIR"/utils.sh

# echo -en "${colors[BGreen]}Enter sudo password:${colors[White]} "
# read -s SUDO_PASS

# TODO: Fix PACKAGES below (missing on Ubuntu)
# xpdf gnome-do

# Install required packages
PACKAGES=(slock xbindkeys clang vim rdesktop make sysstat
	make cmake gitk vlc okular xdotool xbindkeys xautomation mosh mc
	libreoffice cscope ctags pavucontrol jq dmidecode xsel i3 zsh lsb ntp feh help2man rpl
	thunar acpi tmux gitg nomacs docker vpnc
	hexchat rlwrap xautolock yamllint
	eom eog inotify-tools xbacklight arandr pulseaudio gnome-bluetooth
	tidy pandoc tig ncdu redshift rustc
	dunst httpie udev autofs pinta)

SNAP_PACKAGES=(slack code)
RUST_PACKAGES=(rust cargo)

OPTIONAL_PACKAGES=(qt-devel transmission-remote-* transmission-daemon)

NET_TOOLS=(nmap-ncat)

HASKELL=(ghc ghc-Cabal cabal-install)

LATEX=(texlive-listing texlive-pgfopts)

FEDORA=(gnome-icon-theme system-config-printer libreoffice-langpack-pl boost-devel squashfs-tools glibc-devel ghc-ShellCheck pykickstart ImageMagick-devel NetworkManager-tui
	system-config-keyboard seahorse python-devel libxml2-devel libxslt-devel ShellCheck java-1.8.0-openjdk tigervnc
	redhat-rpm-config python3-dnf-plugin-system-upgrade cmake freetype-devel fontconfig-devel
	xclip redshift-gtk texlive-latex-bin-bin ghc-compiler cabal-install R-devel dnf-utils)

RXVT=(rxvt-unicode rxvt-unicode-ml rxvt-unicode-256color rxvt-unicode-256color-ml)

DEBIAN_PACKAGES=(imagemagick python-dev libxml2-dev libxslt-dev libatk-adaptor)
UBUNTU=(libboost-all-dev linux-tools ghc software-properties-common libappindicator-dev vpnc-scripts network-manager-vpnc network-manager-vpnc-gnome exfat-fuse exfat-utils libnotify-bin libboost-all-dev linux-tools terminator fonts-firacode dwm suckless-tools xdm dmenu xorg gnome kde-full ntfs-3g swig libpcsclite-dev pcscd)

KERNEL_DEV=(cscope exuberant-ctags)

POSTGRES=(postgresql-server postgresql-contrib)

JAVA=(java-1.8.0-openjdk-src java-1.8.0-openjdk)

function install_prolog_debian() {
	sudo apt-add-repository ppa:swi-prolog/stable
	sudo apt-get update
	sudo apt-get install swi-prolog
}

function install_yarn_debian() {
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt update && sudo apt install yarn
}

function install_fedora_sound() {
	echo "Installing Video and audio codecs on Fedora"
	su -c "dnf install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

	sudo_exec dnf update

	sudo_exec dnf install -y gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 x264 vlc smplayer
}

function install_snap_packages() {
	sudo snap install slack --classic
}

function install_nord_vpn_debian() {
	wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
	sudo apt-get install ./nordvpn*.deb
	sudo apt update
	sudo apt install -y nordvpn
	rm ./nordvpn*.deb
}

function exit_with_error_message() {
	local -r error_message="$1"
	printf "Error: %s\n" "$error_message"
	return
}

function main() {
	generate_ssh_key

	sudo_keep_alive

	# Remove "Last login" message in new Terminal window open (some UNIX systems)
	touch ~/.hushlogin

	if [ -f /etc/debian_version ]; then
		echo "Installing required packages on Debian/Ubuntu"

		sudo apt-get install --assume-yes curl

		sudo apt-get update
		sudo apt-get install --assume-yes "${PACKAGES[@]}"
		sudo apt-get install --assume-yes "${DEBIAN_PACKAGES[@]}"
		sudo apt-get install --assume-yes zsh

		install_snap_packages
		install_yarn_debian
		#install_debian_chrome
	elif [ -f /etc/redhat-release ]; then
		echo "Installing required packages on Fedora/CentOS"

		dnf install --assumeyes "${PACKAGES[*]}" || exit_with_error_message ""
		dnf install --assumeyes "${FEDORA[*]}" || exit_with_error_message ""
	else # macOS
		#source $DOTFILES_DIR/mac/brew_install.sh

		mac_install_misc
		HOMEBREW_NO_AUTO_UPDATE=1 brew install "${BREW_PACKAGES_MUST_HAVE[*]}"
		HOMEBREW_NO_AUTO_UPDATE=1 brew install "${BREW_PACKAGES_MAY_HAVE[*]}"

		HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "${BREW_CASK_PACKAGES_MUST_HAVE[*]}"
		HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "${BREW_CASK_PACKAGES_MAY_HAVE[*]}"

		sudo chown -R "$USER" /Library/Ruby/Gems/

		# Generate 'locate' database
		sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

		sync_transmission_settings

		"$DOTFILES_DIR"/mac/post_install.sh
	fi
	install_oh_my_zsh || exit_with_error_message ""
	install_zsh_plugins || exit_with_error_message ""

  source "${BASH_SOURCE%/*}/install_global_javascript_npm_packages.sh"
	install_global_javascript_npm_packages || exit_with_error_message ""
	install_vim_plugins || exit_with_error_message ""

	install_tmux_plugin_manager || exit_with_error_message ""

	crontab "$DOTFILES_DIR"/cron.jobs || exit_with_error_message ""
}

function install_vim_plugins() {
	echo "Installing Vim plugins..."
	vim -i NONE -c PlugInstall -c quitall &>/dev/null
}

function install_oh_my_zsh() {
	sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
	chsh --shell "$(which zsh)" "$(whoami)" || exit_with_error_message ""

	rm -rf ~/.oh-my-zsh
	curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sh install.sh --unattended
}

function install_zsh_plugins() {
	echo "Installing zsh plugins"
	# ZSH_CUSTOM=$HOME/zsh_customizations
	# mkdir -p $ZSH_CUSTOM;
	rm -rf "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions && git clone https://github.com/chrisands/zsh-yarn-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions
	rm -rf "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	rm -rf "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin && git clone https://github.com/unixorn/fzf-zsh-plugin.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin
	rm -rf "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
}

function setup_docker() {
	# Add current user to docker group
	sudo_exec groupadd -f docker
	sudo_exec usermod -aG docker "$USER"
	newgrp docker
	sudo_exec chown "$USER" /var/run/docker.sock
}

function install_pip_packages() {
	# PIP packages
	PIP_PACKAGES=(pgcli mycli pyyaml awscli speedtest-cli pika autopep8 pep8
		jupyter jupyterlab dl_coursera z3-solver matplotlib tensorflow numpy agda-kernel
		instalooter pirate-get tensorflow opencv-python virtualenv numpy
		matplotlib protobuf conda haruhi-dl google-api-python-client oauth2client progressbar2
		tdmgr PyQt5 paho-mqtt PyQtWebEngine mvt xmldiff yq poetry beautysh
		yt-dlp speedtest-cli pipupgrade shodan linode-cli mvt jupyter truffleHog
	)

	# Use xargs, so that PIP doesn't fail on a single error
	# xargs -n 1 pip3 install --user <requirements.txt
	# xargs -n 1 pip3 install --user <requirements.txt
	pip3 install --user "${PIP_PACKAGES[@]}" --upgrade

	pip3 install "qiskit[visualization]" --user --upgrade
}

# Git kraken (Linux)
function install_gitkraken() {
	GITKRAKEN_TAR=gitkraken-amd64.tar.gz
	wget https://release.gitkraken.com/linux/$GITKRAKEN_TAR -P tmp
	tar xvf tmp/$GITKRAKEN_TAR tmp/
	mv tmp/gitkraken ~

	sudo_exec ln -s ~/gitkraken/gitkraken /usr/bin/gitkraken
}

function install_intellij_toolbox() {
	wget -q --show-progress https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.4.2492.tar.gz -P tmp
	tar xvf tmp/jetbrains-toolbox-* tmp/
	sudo_exec mv tmp/jetbrains_toolbox /usr/bin
}

function install_k8s() {
	# 1. Clone the kubernetes repository
	git clone https://github.com/kubernetes/kubernetes.git

	# 2. Build the binaries
	cd kubernetes || exit
	KUBE_BUILD_PLATFORMS=linux/amd64 ./hack/build-go.sh
}

function install_rust() {
	# Install rustup.rs.
	curl https://sh.rustup.rs -sSf | sh
}

function install_alacritty() {
	install_rust

	# Clone the source code:
	git clone https://github.com/jwilm/alacritty.git ~/alacritty
	cd alacritty || exit
	# Make sure you have the right Rust compiler installed. Run
	rustup override set stable
	rustup update stable

	cargo build --release

	sudo_exec cp ~/alacritty/target/release/alacritty /usr/bin/
}

function configure_postgres() {
	sudo_exec -u postgres createuser -s "$(whoami)"
	createdb "$(whoami)"
}

function install_haskell_packages() {
	HASKELL_PACKAGES=(happy hscolour funnyprint alex parsec hoogle QuickCheck mtl)
	cabal update
	cabal install "${HASKELL_PACKAGES[*]}"
}

function install_r_packages() {
	R_PACKAGES=() # see r_packages.txt
	echo "install.packages(\"${R_PACKAGES[*]}\", repos=\"https://cran.rstudio.com\")" | R --no-save
}

# TODO: Add it to install script
function install_go_packages() {
	GO_PACKAGES=(github.com/derekparker/delve/cmd/dlv github.com/Sirupsen/logrus
		github.com/mvdan/sh/cmd/shfmt github.com/tomnomnom/gron
		github.com/rverton/webanalyze/cmd/webanalyze mvdan.cc/sh/v3/cmd/shfmt)

	# shellcheck disable=2048
	for package in ${GO_PACKAGES[*]}; do
		go install "$package""@latest"
	done
}

function install_nvidia_driver() {
	sudo_exec dnf config-manager --add-repo=http://negativo17.org/repos/fedora-nvidia.repo
	sudo_exec dnf -y install nvidia-driver nvidia-settings kernel-devel
}

function install_r_studio() {
	sudo_exec dnf install "$(curl -s https://www.rstudio.com/products/rstudio/download/ |
		\grep -o "\"[^ \"]*x86_64.rpm\"" | sed "s/\"//g")"
}

function start_services() {
	systemctl --user enable redshift.service
}

function install_tmux_plugin_manager() {
	local TPM_PATH=~/.tmux/plugins/tpm
	rm -rf $TPM_PATH
	git clone https://github.com/tmux-plugins/tpm $TPM_PATH
}

function install_global_haskell_stack_packages() {
	stack install alex happy hindent haddock hspec
}

function sync_transmission_settings() {
	cp "$HOME"/Library/Preferences/org.m0k.transmission.plist "$HOME"/dotfiles/
}

# Upgrade functions

function ubuntu_upgrade() {
	sudo -s -- <<EOF
apt-get update
apt-get upgrade -y
apt-get full-upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean -y
EOF
}

# main
