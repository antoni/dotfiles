#!/usr/bin/env bash

DOTFILES_DIR=$HOME/dotfiles
MAC_DIR=$DOTFILES_DIR/mac

# Karabiner config
ln -fs "$MAC_DIR"/karabiner ~/.config/

# Transmission config
ln -fs "$MAC_DIR"/org.m0k.transmission.plist "$HOME"/Library/Preferences/
