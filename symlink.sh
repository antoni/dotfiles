#!/bin/bash

# Symlinks all the files in the current directory with corresponding dotfiles in
# the home directory

for file in $(ls -p -I symlink.sh | grep -v /); do 
    rm ~/.$file
    ln -s ~/dotfiles/$file ~/.$file > /dev/null
done
