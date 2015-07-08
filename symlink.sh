#!/bin/bash

DOTFILES_DIR=~/dotfiles
# DOTFILES_DIR='/home/antoni/dotfiles'

# Version of clang-format, should be taken from /usr/bin/clang-format-X.Y
CLANG_FORMAT_VERSION=3.5
DOTFILES=(vimrc tmux.conf gitconfig gitignore ghci gvimrc hgrc)

# Xrdb merge
xrdb $DOTFILES_DIR/Xresources.solarized

# Symlink the files in the current directory with corresponding dotfiles in
# the home directory
for f in "${DOTFILES[@]}"
do
    rm -f ~/.$f
    ln -s ~/dotfiles/$f ~/.$f > /dev/null
done;

# Terminator
ln -fs $DOTFILES_DIR/terminator/config ~/.config/terminator/config

# SSH config
ln -fs $DOTFILES_DIR/sshconfig ~/.ssh/config

# ~/scripts directory
ln -fs $DOTFILES_DIR/scripts ~/scripts

# .ghci access
chmod g-w ~/.ghci

# /usr/bin symlinks
# Chrome
sudo ln -fs /usr/bin/google-chrome-stable /usr/bin/g
# clang-format
sudo ln -fs /usr/bin/clang-format-$CLANG_FORMAT_VERSION /usr/bin/clang-format

# CUDA snippets for Vim
# wget 
# https://gist.githubusercontent.com/antoni/d8ac9973b2f28765b329/raw/811fa82e6ff738e06c11453bfa93d846d76d2386/cuda.snippets 
# && mv cuda.snippets ~/.vim/bundle/vim-snippets/snippets/
