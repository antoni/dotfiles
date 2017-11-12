#!/bin/bash

mkdir -p tmp

source chrome_install.sh

echo -en "${colors[BGreen]}Enter sudo password:${colors[White]} "
read -s SUDO_PASS

source ../utils.sh

# Install required packages
PACKAGES=(slock xbindkeys clang vim vim-X11 rdesktop tigervnc make xpdf sysstat
vim-enhanced vim-X11 make cmake gitk vlc st okular xdotool xbindkeys xautomation mosh mc
libreoffice cscope ctags perf pavucontrol jq dmidecode xsel i3 zsh  libappindicator lsb ntp feh help2man rpl
thunar acpi tmux gitg nomacs docker vpnc vpnc-script NetworkManager-vpnc
hexchat rlwrap xautolock
NetworkManager-vpnc-gnome eom eog inotify-tools xbacklight arandr pulseaudio gnome-bluetooth
tidy pandoc tig ncdu redshift grub-customizer
libnotify dunst httpie udev autofs gnome-do pinta) 

RUST_PACKAGES=(rust cargo)  

OPTIONAL_PACKAGES=(qt-devel transmission-remote-* transmission-daemon)

NET_TOOLS=(nmap-ncat)

HASKELL=(ghc ghc-Cabal cabal-install)

LATEX=(texlive-listing texlive-pgfopts)

FEDORA=(gnome-icon-theme system-config-printer libreoffice-langpack-pl boost-devel squashfs-tools glibc-devel ghc-ShellCheck pykickstart ImageMagick-devel NetworkManager-tui
system-config-keyboard seahorse python-devel libxml2-devel libxslt-devel ShellCheck java-1.8.0-openjdk
redhat-rpm-config python3-dnf-plugin-system-upgrade cmake freetype-devel fontconfig-devel
xclip redshift-gtk texlive-latex-bin-bin ghc-compiler cabal-install R-devel dnf-utils)

RXVT=(rxvt-unicode rxvt-unicode-ml rxvt-unicode-256color rxvt-unicode-256color-ml)

DEBIAN=(gnome-icon-theme-full boost-dev imagemagick python-dev libxml2-dev libxslt-dev)

KERNEL_DEV=(cscope exuberant-ctags)

POSTGRES=(postgresql-server postgresql-contrib)

JAVA=(java-1.8.0-openjdk-src java-1.8.0-openjdk)

function install_fedora_sound() {
    echo "Installing Video and audio codecs on Fedora"
    su -c 'dnf install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

    sudo_exec dnf update

    sudo_exec dnf install -y gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 x264 vlc  smplayer
}

if [ -f /etc/debian_version ]; then
    echo "Installing required packages on Debian"
    apt-get install -y ${PACKAGES[*]} ${DEBIAN[*]}
    install_debian_chrome
elif [ -f /etc/redhat-release ]; then
    echo "Installing required packages on Fedora"
    sudo_exec dnf install -y ${PACKAGES[*]} ${PACKAGES[*]}
    # install_fedora_sound
    install_fedora_chrome
else
    echo "Mac OS X install not supported"
fi

# Generate SSH key
if [ ! -e ~/.ssh/id_rsa ]; then 
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi

function install_oh_my_zsh() {
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    chsh -s /bin/zsh

    install_zsh_plugins
}

function install_zsh_plugins() {
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

function setup_docker() {
    # Add current user to docker group
    sudo_exec groupadd -f docker
    sudo_exec usermod -aG docker $USER
    newgrp docker
    sudo_exec chown $USER /var/run/docker.sock
}

function install_fzf() {
    # install fzf to oh-my-zsh custom plugins directory
    git clone https://github.com/junegunn/fzf.git ${ZSH}/custom/plugins/fzf
    ${ZSH}/custom/plugins/fzf/install --bin
    # install fzf-zsh to oh-my-zsh custom plugins directory
    git clone https://github.com/Treri/fzf-zsh.git ${ZSH}/custom/plugins/fzf-zsh
}

# PIP packages
PIP_PACKAGES=(pgcli mycli)
pip install --user $PIP_PACKAGES

# Git kraken
GITKRAKEN_TAR=gitkraken-amd64.tar.gz
wget https://release.gitkraken.com/linux/$GITKRAKEN_TAR -P tmp
tar xvf tmp/$GITKRAKEN_TAR tmp/
mv tmp/gitkraken ~

sudo_exec ln -s ~/gitkraken/gitkraken /usr/bin/gitkraken

function install_intellij_toolbox() {
    wget -q --show-progress https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.4.2492.tar.gz -P tmp
    tar xvf tmp/jetbrains-toolbox-* tmp/
    sudo_exec mv tmp/jetbrains_toolbox /usr/bin
}

function install_k8s() {
    # 1. Clone the kubernetes repository
    git clone https://github.com/kubernetes/kubernetes.git

    # 2. Build the binaries
    cd kubernetes
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
    cd alacritty
    # Make sure you have the right Rust compiler installed. Run
    rustup override set stable
    rustup update stable

    cargo build --release

    sudo_exec cp ~/alacritty/target/release/alacritty /usr/bin/
}

function configure_postgres() {
    sudo_exec -u postgres createuser -s $(whoami); createdb $(whoami)
}

function install_haskell_packages() {
    HASKELL_PACKAGES=(happy hscolour funnyprint)
    cabal update
    cabal install $HASKELL_PACKAGES
}

function install_go_packages() {
    GO_PACKAGES=(github.com/derekparker/delve/cmd/dlv github.com/Sirupsen/logrus)
    go get -u $GO_PACKAGES
}

function install_nvidia_driver() {
    sudo_exec dnf config-manager --add-repo=http://negativo17.org/repos/fedora-nvidia.repo
    sudo_exec dnf -y install nvidia-driver nvidia-settings kernel-devel
}

function install_r_studio() {
    sudo_exec dnf install $(curl -s https://www.rstudio.com/products/rstudio/download/ |
        \grep -o "\"[^ \"]*x86_64.rpm\"" | sed "s/\"//g");
}
