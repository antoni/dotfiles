#!/usr/bin/env bash

HOME_DIR=$HOME
DOTFILES_DIR=$HOME_DIR/dotfiles
MAC_DIR=$DOTFILES_DIR/mac

# Karabiner config
ln -fs $MAC_DIR/karabiner ~/.config/
