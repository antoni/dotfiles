#!/bin/bash

DOTFILES_DIR='~/dotfiles/'
CLANG_FORMAT_VERSION=3.5
DOTFILES=(vimrc tmux.conf gitconfig gitignore)

# Symlink the files in the current directory with corresponding dotfiles in
# the home directory
for f in "${DOTFILES[@]}"
do
    rm -f ~/.$f
    ln -s ~/dotfiles/$f ~/.$f > /dev/null
done;

# TODO: Terminator
# TODO: Symlink .gitignore
ln -s $DOTFILES_DIR+gitignore ~/.gitignore
# TODO: Symlink .gitconfig
ln -s gitconfig ~/.gitconfig
# TODO: Symlink sshconfig to .ssh/config directory
# TODO: Symlink scripts/ directory
ln -s /home/antoni/dotfiles/eclipse.ini eclipse.ini

# .ghci file
# TODO: Symlink
chmod g-w ~/.ghci

# TODO: .gvimrc, .gitconfig, .hgrc

# /usr/bin symlinks
sudo ln -s /usr/bin/google-chrome-stable /usr/bin/g

# clang-format
sudo ln -r -s /usr/bin/clang-format-$CLANG_FORMAT_VERSION /usr/bin/clang-format

# CUDA snippets for Vim
wget 
https://gist.githubusercontent.com/antoni/d8ac9973b2f28765b329/raw/811fa82e6ff738e06c11453bfa93d846d76d2386/cuda.snippets 
&& mv cuda.snippets ~/.vim/bundle/vim-snippets/snippets/
