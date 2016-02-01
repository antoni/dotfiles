#!/bin/bash

DOTFILES_DIR=~/dotfiles

# Version of clang-format, should be taken from /usr/bin/clang-format-X.Y,
# same for clang-modernize
# CLANG_VERSION=`\ls /usr/bin/clang-?.? -1 | cut -d'-' -f2 | sort -gr | head -1`
CLANG_VERSION=3.7
echo "Clang version symlinked:   " $CLANG_VERSION
CLANG_FORMAT_VERSION=$CLANG_VERSION
CLANG_MODERNIZE_VERSION=$CLANG_VERSION
LLDB_VERSION=3.7
echo "LLDB  version symlinked:   " $LLDB_VERSION
CLION_VERSION=1.2.4
echo "CLion version symlinked:   " $CLION_VERSION

DOTFILES=(bashrc zshrc vimrc paths aliases common_profile.sh tmux.conf gitconfig 
gitignore ghci gvimrc hgrc lldbinit)

# Xrdb merge
xrdb ${DOTFILES_DIR}/Xresources.solarized

# Symlink the files in the current directory with corresponding dotfiles in
# the home directory
for f in "${DOTFILES[@]}"
do
    rm -f ~/.$f
    ln -s ~/dotfiles/$f ~/.$f > /dev/null
done;

# Terminator
ln -fs ${DOTFILES_DIR}/terminator/config ~/.config/terminator/config
# i3-wm
I3WM_DIR=~/.config/i3/
if ! [[ -f $I3WM_DIR ]]; then mkdir -p $I3WM_DIR; fi;
ln -fs ${DOTFILES_DIR}/i3.config ~/.config/i3/config

# SSH config
ln -fs ${DOTFILES_DIR}/sshconfig ~/.ssh/config

# ~/scripts directory
ln -fs ${DOTFILES_DIR}/scripts ~/scripts

# .ghci access
chmod g-w ~/.ghci

# /usr/bin symlinks
# Chrome
sudo ln -fs /usr/bin/google-chrome-stable /usr/bin/g
# clang
sudo ln -fs /usr/bin/clang-$CLANG_VERSION /usr/bin/clang
sudo ln -fs /usr/bin/clang++-$CLANG_VERSION /usr/bin/clang++
# clang-format
sudo ln -fs /usr/bin/clang-format-$CLANG_FORMAT_VERSION /usr/bin/clang-format
# clang-modernize
sudo ln -fs /usr/bin/clang-modernize-$CLANG_MODERNIZE_VERSION /usr/bin/clang-modernize
# lldb
sudo ln -fs /usr/bin/lldb-$LLDB_VERSION /usr/bin/lldb
# Clion
sudo ln -fs /home/antoni/clion-$CLION_VERSION/bin/clion.sh /usr/bin/clion

# Clone Vundle reposiroty (Vim)
VUNDLEDIR=~/.vim/bundle/Vundle.vim
if [ ! "$(ls -A ${VUNDLEDIR})" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLEDIR}
fi

# CUDA snippets for Vim
# wget 
# https://gist.githubusercontent.com/antoni/d8ac9973b2f28765b329/raw/811fa82e6ff738e06c11453bfa93d846d76d2386/cuda.snippets 
# && mv cuda.snippets ~/.vim/bundle/vim-snippets/snippets/
