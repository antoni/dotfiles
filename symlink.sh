#!/usr/bin/env bash

HOME_DIR=$HOME
DOTFILES_DIR=$HOME_DIR/dotfiles

source $DOTFILES_DIR/colors.sh

echo -en "${colors[BGreen]}Enter sudo password:${colors[White]} "
read -s SUDO_PASS

source $DOTFILES_DIR/utils.sh

# Create temp directory
mkdir -p $HOME_DIR/tmp

# Version of clang-format, should be taken from /usr/bin/clang-format-X.Y,
# same for clang-modernize
CLANG_VERSION=3.9
echo "Clang    version symlinked:   " $CLANG_VERSION
CLANG_FORMAT_VERSION=$CLANG_VERSION
CLANG_MODERNIZE_VERSION=$CLANG_VERSION
echo -e "${colors[Green]}"
LLDB_VERSION=3.7
echo "LLDB               version symlinked:   " $LLDB_VERSION
IDEA_VERSION=`echo $HOME/idea-*               | awk -F'-' '{print $3}'`
echo "IntelliJ           version symlinked:   " $IDEA_VERSION
GOGLAND_VERSION=`echo $HOME/Gogland-*         | awk -F'-' '{print $2}'`
echo "Gogland            version symlinked:   " $GOGLAND_VERSION
CLION_VERSION=2017.1.1
echo "CLion              version symlinked:   " $CLION_VERSION
JMETER_VERSION=`echo $HOME/apache-jmeter-*    | awk -F'-' '{print $3}'`
echo "JMeter             version symlinked:   " $JMETER_VERSION
SWEET_HOME_VERSION=`echo $HOME/SweetHome3D-*  | awk -F'-' '{print $2}'`
echo "SweetHome3D        version symlinked:   " $SWEET_HOME_VERSION
echo -e "${colors[White]}"

DOTFILES=(profile bashrc zshrc vimrc paths aliases common_profile.sh tmux.conf \
    gitconfig gitignore ghci gvimrc hgrc lldbinit gdbinit xbindkeysrc \
    optional.sh eslintrc fzf.sh psqlrc colordiffrc \
    jupyter) # Directories

function mac_change_hostname() {
    # Fully qualified hostname, for example myMac.domain.com
    sudo scutil --set HostName $1
    # Name usable on the local network, for example myMac.local.
    sudo scutil --set LocalHostName $1
    # User-friendly computer name you see in Finder, for example myMac.
    sudo scutil --set ComputerName $1
}

# Xrdb merge
XRES_FILE=Xresources.solarized
xrdb ${DOTFILES_DIR}/${XRES_FILE}
ln -sf ${DOTFILES_DIR}/${XRES_FILE} ~/.Xresources

# Symlink the files in the current directory with corresponding dotfiles in
# the home directory
for f in "${DOTFILES[@]}"
do
    rm -f ~/.$f
    ln -s ~/dotfiles/$f ~/.$f > /dev/null
done;

# Terminator
mkdir -p ~/.config/terminator
ln -fs ${DOTFILES_DIR}/terminator/config ~/.config/terminator/config

# Alacritty
mkdir -p ~/.config/alacritty
ln -fs ${DOTFILES_DIR}/alacritty.yml ~/.config/alacritty/alacritty.yml

# dunst (notifications)
mkdir -p ~/.config/dunst
ln -fs ${DOTFILES_DIR}/dunstrc ~/.config/dunst/dunstrc

# pgcli
mkdir -p ~/.config/pgcli
ln -fs ${DOTFILES_DIR}/pgcli ~/.config/pgcli/config

# htop
mkdir -p ~/.config/htop
ln -fs ${DOTFILES_DIR}/htoprc ~/.config/htop/

# i3-wm
I3WM_DIR=~/.config/i3/
if ! [[ -f $I3WM_DIR ]]; then
    mkdir -p $I3WM_DIR;
fi

ln -fs ${DOTFILES_DIR}/i3/i3.config ~/.config/i3/config
ln -fs ${DOTFILES_DIR}/i3/i3status.config ~/.config/i3/i3status.config

# Redshift
if [[ ! -a ~/.config/redshift.conf ]]; then
    mkdir -p ~/.config
    ln -s ${DOTFILES_DIR}/redshift.conf ~/.config/redshift.conf
fi

# MIME types
MIME_FILE=$HOME/.config/mimeapps.list
if [ -e ~/.ssh/id_rsa ]; then 
    rm -f $MIME_FILE
fi
ln -fs ${DOTFILES_DIR}/config/mimeapps.list $MIME_FILE 

# SSH config
ln -fs ${DOTFILES_DIR}/sshconfig ~/.ssh/config

# ~/scripts directory
function setup_scripts() {
    if [ -d "scripts" ]; then
        git clone git@github.com:antoni/scripts.git;
    fi 
    ln -fs ${DOTFILES_DIR}/scripts ~/scripts

    # Screenshots
    sudo_exec ln -fs $HOME/scripts/st.sh /bin/st
}

# setup_scripts

# .ghci access
chmod g-w ~/.ghci

set -x # echo executed commands

# /usr/bin symlinks

# Chrome
sudo_exec ln -fs /usr/bin/google-chrome-stable /usr/bin/g
# Firefox
# sudo_exec ln -fs /usr/bin/firefox /usr/bin/f
sudo_exec ln -fs $HOME/firefox/firefox /usr/bin/f
# Eclipse
sudo_exec ln -fs ~$HOME_DIR/eclipse/eclipse /usr/bin/eclipse
# clang
sudo_exec ln -fs /usr/bin/clang-$CLANG_VERSION /usr/bin/clang
sudo_exec ln -fs /usr/bin/clang++-$CLANG_VERSION /usr/bin/clang++
# clang-format
# sudo_exec ln -fs /usr/bin/clang-format-$CLANG_FORMAT_VERSION /usr/bin/clang-format
# clang-modernize
# sudo_exec ln -fs /usr/bin/clang-modernize-$CLANG_MODERNIZE_VERSION /usr/bin/clang-modernize

# adb 
sudo_exec ln -fs $HOME_DIR/Android/Sdk/platform-tools/adb /usr/bin/adb

# IDEA
sudo_exec mkdir -p /etc/sysctl.d
sudo_exec ln -fs ${DOTFILES_DIR}/intellij/idea_sysctl.conf /etc/sysctl.d/idea_sysctl.conf
sudo_exec sysctl -p --system

# Global aliases
sudo_exec mkdir -p /etc/profile.d
sudo_exec ln -fs ${DOTFILES_DIR}/global_aliases /etc/profile.d/global_aliases.sh

# lldb
sudo_exec ln -fs /usr/bin/lldb-$LLDB_VERSION /usr/bin/lldb
# IDEA
sudo_exec ln -fs $HOME_DIR/idea-I?-$IDEA_VERSION/bin/idea.sh /usr/bin/idea
# Clion
sudo_exec ln -fs $HOME_DIR/clion-$CLION_VERSION/bin/clion.sh /usr/bin/clion
# Gogland
sudo_exec ln -fs $HOME_DIR/Gogland-$GOGLAND_VERSION/bin/gogland.sh /usr/bin/gogland
# JMeter
sudo_exec ln -fs $HOME_DIR/apache-jmeter-$JMETER_VERSION/bin/jmeter /usr/bin/jmeter
# Robo 3T
sudo_exec ln -fs $HOME_DIR/robo3t-*/bin/robo3t /usr/bin/robo3t
# SweetHome3D
sudo_exec ln -fs $HOME_DIR/SweetHome3D-$SWEET_HOME_VERSION/SweetHome3D /usr/bin/sweethome
# Sublime 3
if [ -e $HOME/sublime_text_3 ]; then
    sudo_exec ln -fs $HOME/sublime_text_3/sublime_text /usr/bin/sublime
fi

if [ -e $HOME/android-studio ]; then
    sudo_exec ln -fs $HOME/android-studio/bin/studio.sh /bin/astudio
fi

case "$(uname -s)" in
    Darwin)
        ln -fs ${DOTFILES_DIR}/dotfiles/vscode.json $HOME/Library/Application\ Support/Code/User/settings.json
        ;;
    Linux)
        ln -fs ${DOTFILES_DIR}/dotfiles/vscode.json $HOME/.config/Code/User/settings.json
        ;;
    CYGWIN*|MINGW32*|MSYS*) # MS Windows
        ;;
esac

set +x # disable echo executed commands

# Vim

# Clone Vundle repository
VUNDLEDIR=~/.vim/bundle/Vundle.vim
if [ ! "$(ls -A ${VUNDLEDIR})" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLEDIR}
fi

# CUDA snippets for Vim
# wget 
# https://gist.githubusercontent.com/antoni/d8ac9973b2f28765b329/raw/811fa82e6ff738e06c11453bfa93d846d76d2386/cuda.snippets 
# && mv cuda.snippets ~/.vim/bundle/vim-snippets/snippets/

echo -e "${colors[BYellow]}Things to be (possibly) done manually:\n\n\
    \t* /sys/class/backlight/\t\tto make xbacklight work"${colors[BWhite]}

sudo cp brightness.sh /root/
sudo sh -c 'echo "$USER $(hostname) = NOPASSWD: /root/brightness.sh" >> /etc/sudoers'

function setup_hostname() {
    hostname_default="automatown"
    echo -en "${colors[BGreen]}Enter hostname for the current machine [$hostname_default]:${colors[White]} "
    read hostname
    hostname=${hostname:-$hostname_default}
    # TODO: OS check
    # hostnamectl set-hostname $hostname

    mac_change_hostname $hostname

    echo -e "${colors[BGreen]}Hostname changed to:${colors[BBlue]} $hostname ${colors[White]}"
}

setup_hostname

# Midnight Commander
ln -fs $DOTFILES_DIR/mc ~/.config

# Fedora regular updates
function fedora_regular_updates() {
    sudo dnf install dnf-automatic
    sudo systemctl enable dnf-automatic.timer && systemctl start dnf-automatic.timer
}

# Fedora upgrade
function fedora_system_upgrade() {
    sudo dnf install python3-dnf-plugin-system-upgrade
    sudo dnf system-upgrade download --refresh --releasever=26
    sudo dnf system-upgrade reboot
}

# JS-related tools

# Make global packages install locally (without sudo)
function install_npm() {
    NPM_DIR=$HOME/.npm-global;
    mkdir -p $NPM_DIR;
    npm config set prefix "$NPM_DIR";
}

function install_npm_packages() {
    npm install -g eslint lodash jshint typescript ts-node tslint prettier \
        http-server depcheck npm-check-updates prettier sort-package-json \
        babel-cli pm2@latest alfred-vpn
    }

function install_yarn_packages() {
    yarn global add tslint typescript
}

function install_airbnb_eslint() {
    export PKG=eslint-config-airbnb;
    npm info "$PKG@latest" peerDependencies --json | command sed 's/[\{\},]//g ; s/:
    /@/g' | xargs npm install -g "$PKG@latest"
}

# install_npm_packages
# install_airbnb_eslint

# Atom

mkdir -p $HOME/.atom

for atom in `\ls atom`; do
    rm -f $HOME/.atom/$atom;
    ln -fs ~/dotfiles/atom/$atom $HOME/.atom/$atom;
done

echo -e '\033[1;29;42m DONE \033[0m \033[1;32mSuccessfully symlinked all files\033[0m'

