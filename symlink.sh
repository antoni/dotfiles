#!/bin/bash

# Clone this repo file into ~ to make it work
DOTFILES_DIR=~/dotfiles

# Version of clang-format, should be taken from /usr/bin/clang-format-X.Y,
# same for clang-modernize
# CLANG_VERSION=3.9
# echo "Clang    version symlinked:   " $CLANG_VERSION
# CLANG_FORMAT_VERSION=$CLANG_VERSION
# CLANG_MODERNIZE_VERSION=$CLANG_VERSION
LLDB_VERSION=3.7
echo "LLDB     version symlinked:   " $LLDB_VERSION
IDEA_VERSION=`echo $HOME/idea-* | awk -F'-' '{print $3}'`
echo "IntelliJ version symlinked:   " $IDEA_VERSION
CLION_VERSION=2017.1.1
echo "CLion    version symlinked:   " $CLION_VERSION

DOTFILES=(profile bashrc zshrc vimrc paths aliases common_profile.sh tmux.conf gitconfig gitignore ghci gvimrc hgrc lldbinit gdbinit xbindkeysrc optional.sh)

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
sudo ln -fs /usr/bin/google-chrome-stable /usr/bin/g
# Eclipse
sudo ln -fs ~/eclipse/eclipse /usr/bin/eclipse
# clang
# sudo ln -fs /usr/bin/clang-$CLANG_VERSION /usr/bin/clang
# sudo ln -fs /usr/bin/clang++-$CLANG_VERSION /usr/bin/clang++
# clang-format
# sudo ln -fs /usr/bin/clang-format-$CLANG_FORMAT_VERSION /usr/bin/clang-format
# clang-modernize
# sudo ln -fs /usr/bin/clang-modernize-$CLANG_MODERNIZE_VERSION /usr/bin/clang-modernize

# IDEA

sudo mkdir -p /etc/sysctl.d
sudo ln -fs ${DOTFILES_DIR}/intellij/idea_sysctl.conf /etc/sysctl.d/idea_sysctl.conf
sudo sysctl -p --system

# lldb
sudo ln -fs /usr/bin/lldb-$LLDB_VERSION /usr/bin/lldb
# IDEA
sudo ln -fs /home/antoni/idea-IC-$IDEA_VERSION/bin/idea.sh /usr/bin/idea
# Clion
sudo ln -fs /home/antoni/clion-$CLION_VERSION/bin/clion.sh /usr/bin/clion
# Screenshots
sudo ln -fs $HOME/scripts/st.sh /bin/st

if [ -e $HOME/android-studio ]; then
    sudo ln -fs $HOME/android-studio/bin/studio.sh /bin/astudio
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

