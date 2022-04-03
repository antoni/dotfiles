#!/usr/bin/env bash
DOTFILES_DIR=~/dotfiles

mkdir -p tmp

source $DOTFILES_DIR/install/chrome_install.sh

# echo -en "${colors[BGreen]}Enter sudo password:${colors[White]} "
# read -s SUDO_PASS

source $DOTFILES_DIR/utils.sh

# Install required packages
PACKAGES=(slock xbindkeys clang vim rdesktop make xpdf sysstat
	nodejs make cmake gitk vlc okular xdotool xbindkeys xautomation mosh mc
	libreoffice cscope ctags pavucontrol jq dmidecode xsel i3 zsh lsb ntp feh help2man rpl
	thunar acpi tmux gitg nomacs docker vpnc
	hexchat rlwrap xautolock yamllint
	eom eog inotify-tools xbacklight arandr pulseaudio gnome-bluetooth
	tidy pandoc tig ncdu redshift rustc
	dunst httpie udev autofs gnome-do pinta)

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

DEBIAN=(imagemagick python-dev libxml2-dev libxslt-dev)
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
	su -c 'dnf install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

	sudo_exec dnf update

	sudo_exec dnf install -y gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 x264 vlc smplayer
}

function generate_ssh_key() {

	if [ ! -e ~/.ssh/id_rsa ]; then
		ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
	fi
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

function main() {

	# TODO: Use script from separate file
	# generate_ssh_key

	# Generate SSH key
	# if [ ! -e ~/.ssh/id_rsa ]; then
	#    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
	# fi

	if [ -f /etc/debian_version ]; then
		echo "Installing required packages on Debian/Ubuntu"

		sudo apt install curl
		# Add sources
		curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

		sudo apt install -y "${PACKAGES[*]}" "${DEBIAN[*]}"
		install_snap_packages
		install_yarn_debian
		#install_debian_chrome
	elif [ -f /etc/redhat-release ]; then
		echo "Installing required packages on Fedora"
		sudo_exec dnf install -y "${PACKAGES[*]}"
		${FEDORA[*]}
		# install_fedora_sound
		install_fedora_chrome
	else # macOS
		#source $DOTFILES_DIR/mac/brew_install.sh

		# Remove "Last login" message in new Terminal window open
		touch ~/.hushlogin

		#mac_install_misc
		HOMEBREW_NO_AUTO_UPDATE=1 brew install "${BREW_PACKAGES[*]}"
		HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "${BREW_CASK_PACKAGES[*]}"

		sudo chown -R "$USER" /Library/Ruby/Gems/

		# Generate 'locate' database
		sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

		$DOTFILES_DIR/mac/post_install.sh
	fi
	install_oh_my_zsh
	install_zsh_plugins
	install_fzf

	install_javascript_packages_npm
	# install_airbnb_eslint
	install_vim_plugins

	install_tmux_plugin_manager

	crontab $DOTFILES_DIR/cron.jobs
}

function install_vim_plugins() {
	echo "Installing Vim plugins..."
	vim -i NONE -c VundleInstall -c quitall &>/dev/null
}

function install_oh_my_zsh() {
	sudo chsh -s $(which zsh) $(whoami)

	curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sh install.sh --unattended
}

function install_zsh_plugins() {
	# ZSH_CUSTOM=$HOME/zsh_customizations
	# mkdir -p $ZSH_CUSTOM;
	# git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
	# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
	git clone https://github.com/chrisands/zsh-yarn-completions ~/.oh-my-zsh/custom/plugins/zsh-yarn-completions
}

function setup_docker() {
	# Add current user to docker group
	sudo_exec groupadd -f docker
	sudo_exec usermod -aG docker "$USER"
	newgrp docker
	sudo_exec chown "$USER" /var/run/docker.sock
}

function install_fzf() {
	# install fzf to oh-my-zsh custom plugins directory
	git clone https://github.com/junegunn/fzf.git "${ZSH}"/custom/plugins/fzf
	"${ZSH}"/custom/plugins/fzf/install --bin
	# install fzf-zsh to oh-my-zsh custom plugins directory
	git clone https://github.com/Treri/fzf-zsh.git "${ZSH}"/custom/plugins/fzf-zsh
}

function install_pip_packages() {
	# PIP packages
	PIP_PACKAGES=(pgcli mycli pyyaml awscli speedtest-cli pika autopep8 pep8
		jupyter jupyterlab dl_coursera z3-solver matplotlib tensorflow numpy agda-kernel
		instalooter pirate-get tensorflow opencv-python virtualenv numpy
		matplotlib protobuf conda haruhi-dl google-api-python-client oauth2client progressbar2
		tdmgr PyQt5 paho-mqtt PyQtWebEngine mvt)

	# Use xargs, so that PIP doesn't fail on a single error
	cat requirements.txt | xargs -n 1 pip install --user
	cat requirements.txt | xargs -n 1 pip install --user
	# pip install --user $PIP_PACKAGES --upgrade
	# pip3 install --user $PIP_PACKAGES --upgrade

	pip install "qiskit[visualization]" --user --upgrade
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
	sudo_exec -u postgres createuser -s $(whoami)
	createdb $(whoami)
}

function install_haskell_packages() {
	HASKELL_PACKAGES=(happy hscolour funnyprint alex parsec hoogle QuickCheck mtl)
	cabal update
	cabal install "$HASKELL_PACKAGES"
}

function install_r_packages() {
	R_PACKAGES=() # see r_packages.txt
	# TODO: Install all packages
	echo "install.packages(\"${R_PACKAGES[*]}\", repos=\"https://cran.rstudio.com\")" | R --no-save
}

function install_go_packages() {
	GO_PACKAGES=(github.com/derekparker/delve/cmd/dlv github.com/Sirupsen/logrus)
	go get -u "$GO_PACKAGES"
}

function install_nvidia_driver() {
	sudo_exec dnf config-manager --add-repo=http://negativo17.org/repos/fedora-nvidia.repo
	sudo_exec dnf -y install nvidia-driver nvidia-settings kernel-devel
}

function install_r_studio() {
	sudo_exec dnf install $(curl -s https://www.rstudio.com/products/rstudio/download/ |
		\grep -o "\"[^ \"]*x86_64.rpm\"" | sed "s/\"//g")
}

function start_services() {
	systemctl --user enable redshift.service
}

function install_tmux_plugin_manager() {
	local TPM_PATH=~/.tmux/plugins/tpm
	rm -rf $TPM_PATH
	git clone https://github.com/tmux-plugins/tpm $TPM_PATH
}

# JS-related tools

# Make global packages install locally (without sudo)
function install_npm() {
	NPM_DIR=$HOME/.npm-global
	mkdir -p "$NPM_DIR"
	npm config set prefix "$NPM_DIR"
}

function install_javascript_packages_npm() {
	npm install -g eslint lodash jshint typescript ts-node tslint prettier \
		http-server http-server-spa json-server depcheck npm-check-updates prettier sort-package-json \
		babel-cli pm2@latest alfred-vpn firebase-tools tslint typescript \
		@aws-amplify/cli pa11y netlify-cli hygen react-native-cli serve \
		@zeplin/cli @zeplin/cli-connect-react-plugin @zeplin/cli-connect-swift-plugin \
		yo generator-office dts-gen yargs rollup pnpm source-map-explorer \
		@angular/cli n json5 cordova gltf-pipeline @squoosh/cli depcheck @microsoft/rush \
		do-not-disturb-cli katex servor degit verdaccio tables gatsby-cli browser-sync \
		@apidevtools/swagger-cli kill-port-process
}

function install_airbnb_eslint() {
	export PKG=eslint-config-airbnb
	npm info "$PKG@latest" peerDependencies --json | command sed 's/[\{\},]//g ; s/:
    /@/g' | xargs npm install -g "$PKG@latest"
}

function install_global_haskell_stack_packages() {
	stack install alex happy hindent haddock hspec
}

# TODO: macOS only
# TODO: Download DMG, then use it
function install_java_8() {
	sudo hdiutil attach ~/scripts/java/jdk-8u231-macosx-x64.dmg
	sudo installer -package /Volumes/JDK\ 8\ Update\ 231/JDK\ 8\ Update\ 231.pkg -target /
}

# main
