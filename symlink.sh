#!/bin/bash

HOME_DIR=$HOME
DOTFILES_DIR=$HOME_DIR/dotfiles

source $DOTFILES_DIR/colors.sh

echo -en "${colors[BGreen]}Enter sudo password:${colors[White]} "
read -s SUDO_PASS

function sudo_exec() {
    sudo -S <<< $SUDO_PASS $@
}

# Version of clang-format, should be taken from /usr/bin/clang-format-X.Y,
# same for clang-modernize
CLANG_VERSION=3.9
echo "Clang    version symlinked:   " $CLANG_VERSION
CLANG_FORMAT_VERSION=$CLANG_VERSION
CLANG_MODERNIZE_VERSION=$CLANG_VERSION
echo -e "${colors[Green]}"
LLDB_VERSION=3.7
echo "LLDB               version symlinked:   " $LLDB_VERSION
IDEA_VERSION=`echo $HOME/idea-* | awk -F'-' '{print $3}'`
echo "IntelliJ           version symlinked:   " $IDEA_VERSION
GOGLAND_VERSION=`echo $HOME/Gogland-* | awk -F'-' '{print $2}'`
echo "Gogland            version symlinked:   " $GOGLAND_VERSION
CLION_VERSION=2017.1.1
echo "CLion              version symlinked:   " $CLION_VERSION
echo -e "${colors[White]}"

DOTFILES=(profile bashrc zshrc vimrc paths aliases common_profile.sh tmux.conf gitconfig
gitignore ghci gvimrc hgrc lldbinit gdbinit xbindkeysrc optional.sh eslintrc fzf.sh)

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
# i3-wm
I3WM_DIR=~/.config/i3/
if ! [[ -f $I3WM_DIR ]]; then
    mkdir -p $I3WM_DIR;
fi;

ln -fs ${DOTFILES_DIR}/i3/i3.config ~/.config/i3/config
ln -fs ${DOTFILES_DIR}/i3/i3status.config ~/.config/i3/i3status.config

ln -fs ${DOTFILES_DIR}/config/mimeapps.list ~/.config/mimeapps.list

# SSH config
ln -fs ${DOTFILES_DIR}/sshconfig ~/.ssh/config

# ~/scripts directory
ln -fs ${DOTFILES_DIR}/scripts ~/scripts

# .ghci access
chmod g-w ~/.ghci

set -x # echo executed commands

# /usr/bin symlinks
# Chrome
sudo_exec ln -fs /usr/bin/google-chrome-stable /usr/bin/g
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
# IDEA
sudo_exec ln -fs $HOME_DIR/Gogland-$GOGLAND_VERSION/bin/gogland.sh /usr/bin/gogland
# Screenshots
sudo_exec ln -fs $HOME/scripts/st.sh /bin/st

if [ -e $HOME/android-studio ]; then
    sudo_exec ln -fs $HOME/android-studio/bin/studio.sh /bin/astudio
fi;

set +x

# Clone Vundle reposiroty (Vim)
VUNDLEDIR=~/.vim/bundle/Vundle.vim
if [ ! "$(ls -A ${VUNDLEDIR})" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLEDIR}
fi

# CUDA snippets for Vim
# wget 
# https://gist.githubusercontent.com/antoni/d8ac9973b2f28765b329/raw/811fa82e6ff738e06c11453bfa93d846d76d2386/cuda.snippets 
# && mv cuda.snippets ~/.vim/bundle/vim-snippets/snippets/

# Optional: go get
# GO_PACKAGES=(github.com/derekparker/delve/cmd/dlv github.com/Sirupsen/logrus)
# go get -u $GO_PACKAGES

# Create temp directory
mkdir -p $HOME_DIR/tmp

echo -e "${colors[BYellow]}Things to be (possibly) done manually:\n\n\
    \t* /sys/class/backlight/\t\tto make xbacklight work"${colors[BWhite]}

sudo cp brightness.sh /root/
sudo sh -c 'echo "$USER $(hostname) = NOPASSWD: /root/brightness.sh" >> /etc/sudoers'

function setup_hostname() {
    hostname_default="miramar"
    echo -en "${colors[BGreen]}Enter hostname for the current machine [$hostname_default]:${colors[White]} "
    read hostname
    hostname=${name:-$hostname_default}
    hostnamectl set-hostname $hostname
    echo -e "${colors[BGreen]}Hostname changed to:${colors[BBlue]} $hostname ${colors[White]}"
}

setup_hostname

# Midnight Commander
ln -fs $DOTFILES_DIR/mc ~/.config


# JS-related tools
NPM_DIR=$HOME/.npm
mkdir -p $NPM_DIR
sudo_exec chown -R $(whoami) $NPM_DIR

function install_npm_packages() {
    sudo_exec npm install -g eslint lodash
}

# TODO: Fix this to install globally
function install_airbnb_eslint() {
    export PKG="eslint-config-airbnb";
    npm info "$PKG@latest" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs npm install --save-dev "$PKG@latest";
}

# install_npm_packages
# install_airbnb_eslint
