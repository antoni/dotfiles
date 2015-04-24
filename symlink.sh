#!/bin/bash

DOTFILES_DIR='~/dotfiles/'

# Symlinks all the files in the current directory with corresponding dotfiles in
# the home directory

for file in $(ls -p -I symlink.sh | grep -v /); do 
    rm ~/.$file
    ln -s ~/dotfiles/$file ~/.$file > /dev/null
done

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
