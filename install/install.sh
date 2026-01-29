#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME"/dotfiles

mkdir -p tmp

# TODO: Move somewhere else, install everything from dotfiles/install directory?
# source "$DOTFILES_DIR"/install/install_chrome.sh
source "$DOTFILES_DIR"/mac/brew_install.sh
source "$DOTFILES_DIR"/utils.sh
source "$DOTFILES_DIR"/colors.sh
source "$(dirname "$0")/pipx_packages.sh" || exit 1

# Install required packages
PACKAGES=(coreutils gawk sed grep findutils diffutils
	gettext jq dmidecode xsel zsh ruby udev
  make cmake  clang vim gitk vlc
	suckless-tools rdesktop make sysstat
	okular xdotool xbindkeys xautomation mosh mc
	libreoffice cscope universal-ctags pavucontrol i3 feh help2man rpl
	thunar acpi tmux gitg nomacs vpnc
	hexchat rlwrap yamllint
	eom eog inotify-tools xbacklight pulseaudio
	tidy pandoc tig ncdu redshift rustc
	dunst httpie autofs)

# TODO: Decide what to do with these packages (wrong names when installing on Debian GNU/Linux 13 (trixie))
# xautolock pinta lsb ntp docker gnome-bluetooth

SNAP_PACKAGES=(slack code)
RUST_PACKAGES=(rust cargo)

OPTIONAL_PACKAGES=(qt-devel transmission-remote-* transmission-daemon xpdf)

NET_TOOLS=(nmap-ncat)

HASKELL=(ghc ghc-Cabal cabal-install)

LATEX=(texlive-listing texlive-pgfopts)

FEDORA=(gnome-icon-theme system-config-printer libreoffice-langpack-pl boost-devel squashfs-tools glibc-devel ghc-ShellCheck pykickstart ImageMagick-devel NetworkManager-tui
	system-config-keyboard seahorse python-devel libxml2-devel libxslt-devel ShellCheck java-1.8.0-openjdk tigervnc
	redhat-rpm-config python3-dnf-plugin-system-upgrade cmake freetype-devel fontconfig-devel
	xclip redshift-gtk texlive-latex-bin-bin ghc-compiler cabal-install R-devel dnf-utils)

RXVT=(rxvt-unicode rxvt-unicode-ml rxvt-unicode-256color rxvt-unicode-256color-ml)

DEBIAN_PACKAGES=(imagemagick libxml2-dev libxslt-dev libatk-adaptor)
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
	sudo mkdir -p /usr/share/keyrings

	curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg |
		sudo gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg

	echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" |
		sudo tee /etc/apt/sources.list.d/yarn.list >/dev/null

	sudo apt-get update -q
	sudo apt-get install -y -qq yarn -o Dpkg::Use-Pty=0
}

function install_fedora_sound() {
	echo "Installing Video and audio codecs on Fedora"
	su -c "dnf install --assumeyes --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

	sudo_exec dnf update

	sudo_exec dnf install --assumeyes gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 x264 vlc smplayer
}

function install_snap_packages() {
#!/usr/bin/env bash
set -euo pipefail

echo "==> Ensuring snapd is installed"

if ! dpkg -s snapd >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y snapd
else
  echo "snapd already installed"
fi

echo "==> Ensuring snapd service is enabled and running"

if ! systemctl is-enabled snapd >/dev/null 2>&1; then
  sudo systemctl enable snapd
else
  echo "snapd service already enabled"
fi

if ! systemctl is-active snapd >/dev/null 2>&1; then
  sudo systemctl start snapd
else
  echo "snapd service already running"
fi

echo "==> Ensuring /snap symlink exists"

if [ ! -e /snap ]; then
  sudo ln -s /var/lib/snapd/snap /snap
  echo "Created /snap symlink"
else
  echo "/snap already exists"
fi

echo "==> Verifying snap installation"
snap version || {
  echo "Snap installed, but a logout/login or reboot may be required."
}

echo "==> Done"

	sudo snap install slack --classic
}

function install_nord_vpn_debian() {
	wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
	sudo apt-get install ./nordvpn*.deb
	sudo apt update
	sudo apt --assume-yes install nordvpn
	rm ./nordvpn*.deb
}

function main() {
	generate_ssh_key

	sudo_keep_alive

	if [[ -n "$IS_WSL" ]]; then
		source "$HOME"/dotfiles/windows/wsl-fixes/apply_wsl_fixes.sh
	fi

	# Remove "Last login" message in new Terminal window open (some UNIX systems)
	touch ~/.hushlogin

	if [ -f /etc/debian_version ]; then
		printf "Installing required packages on Debian/Ubuntu\n"

		sudo apt-get update -qq
		sudo apt-get install -y -qq curl \
			-o Dpkg::Use-Pty=0

		sudo apt-get install -y -qq "${PACKAGES[@]}" \
			-o Dpkg::Use-Pty=0

		sudo apt-get install -y -qq "${DEBIAN_PACKAGES[@]}" \
			-o Dpkg::Use-Pty=0

		sudo apt-get install -y -qq zsh \
			-o Dpkg::Use-Pty=0

		install_snap_packages

		~/dotfiles/install/install_node_lts.sh
		# TODO: Remove this func
		# install_yarn_debian
	elif [ -f /etc/redhat-release ]; then
		echo "Installing required packages on Fedora/CentOS"

		dnf install --assumeyes "${PACKAGES[*]}" || exit_with_error_message ""
		dnf install --assumeyes "${FEDORA[*]}" || exit_with_error_message ""
	else # macOS
		source "$DOTFILES_DIR"/mac/brew_install.sh

		mac_install_misc
		HOMEBREW_NO_AUTO_UPDATE=1 brew install "${BREW_PACKAGES_MUST_HAVE[@]}"
		HOMEBREW_NO_AUTO_UPDATE=1 brew install "${BREW_PACKAGES_MAY_HAVE[@]}"

		HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "${BREW_CASK_PACKAGES_MUST_HAVE[@]}"
		HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "${BREW_CASK_PACKAGES_MAY_HAVE[@]}"

		sudo chown -R "$USER" /Library/Ruby/Gems/

		# Generate 'locate' database
		sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

		sync_transmission_settings

		"$DOTFILES_DIR"/mac/post_install.sh
	fi

	if [[ "$UNAME_OUTPUT" == 'Linux' ]]; then
		sudo locale-gen en_US.UTF-8
		sudo locale-gen en_GB.UTF-8
	fi

	~/dotfiles/symlink.sh

# Needs to be installed using zsh, not bash
	"$HOME/dotfiles/install/install_oh_my_zsh.sh"|| exit_with_error_message "Could not install oh-my-zsh"

# TODO: Put this inside install_imagemagick_v7
if command -v magick >/dev/null 2>&1 || command -v convert >/dev/null 2>&1; then
    echo "ImageMagick (preinstalled on the system) detected. Proceeding with removal..."

    sudo apt purge -y imagemagick imagemagick-6-common || true
    sudo apt purge -y 'libmagick*6*' || true
    sudo apt autoremove --purge -y

    if [ -d /etc/ImageMagick-6 ]; then
        sudo rm -rf /etc/ImageMagick-6
    fi

    echo "ImageMagick (preinstalled with the system) cleanup complete."
else
    echo "ImageMagick not installed with the system. No need to remove it"
fi
	"$HOME/dotfiles/install/install_imagemagick_v7.sh"  || exit_with_error_message "Could not install ImageMagick"

	source "${BASH_SOURCE%/*}/install_global_javascript_npm_packages.sh"
	install_global_javascript_npm_packages || exit_with_error_message "Could not install global npm packages"
	install_vim_plugins || exit_with_error_message "Could not install vim plugins"

	install_tmux_plugin_manager || exit_with_error_message "Could not install tmux"

	source "$DOTFILES_DIR"/install/install_go.sh || exit_with_error_message "Could not install golang"

	"$HOME"/dotfiles/install/install_rust.sh
	"$HOME"/dotfiles/install/install_cargo_crates.sh
	"$HOME"dotfiles/install/install_chrome.sh

	source "$DOTFILES_DIR"/install/pipx_packages.sh && install_pipx_packages || exit_with_error_message "Could not install pipx packages"

	crontab "$DOTFILES_DIR"/cron.jobs || exit_with_error_message ""
}

function install_vim_plugins() {
	echo "Installing Vim plugins..."
	vim -i NONE -c PlugInstall -c quitall &>/dev/null
}

function setup_docker() {
	# Add current user to docker group
	sudo_exec groupadd -f docker
	sudo_exec usermod -aG docker "$USER"
	newgrp docker
	sudo_exec chown "$USER" /var/run/docker.sock
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

function install_nvidia_driver() {
	sudo_exec dnf config-manager --add-repo=http://negativo17.org/repos/fedora-nvidia.repo
	sudo_exec dnf --assumeyes install nvidia-driver nvidia-settings kernel-devel
}

function install_r_studio() {
	sudo_exec dnf install --assumeyes "$(curl -s https://www.rstudio.com/products/rstudio/download/ |
		\grep -o "\"[^ \"]*x86_64.rpm\"" | sed "s/\"//g")"
}

function start_services() {
	systemctl --user enable redshift.service
}

function install_tmux_plugin_manager() {
	local TPM_PATH=~/.tmux/plugins/tpm
	rm --recursive --force $TPM_PATH
	git clone https://github.com/tmux-plugins/tpm $TPM_PATH
}

function install_global_haskell_stack_packages() {
	stack install alex happy hindent haddock hspec
}

function sync_transmission_settings() {
	cp "$HOME"/Library/Preferences/org.m0k.transmission.plist "$HOME"/dotfiles/
}

function ubuntu_upgrade() {
	sudo -s -- <<EOF
apt-get update
apt-get upgrade --assume-yes
apt-get full-upgrade --assume-yes
apt-get dist-upgrade --assume-yes
apt-get autoremove --assume-yes
apt-get autoclean --assume-yes
EOF
}

main
