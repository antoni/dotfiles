#!/usr/bin/env bash

source "$HOME"/dotfiles/utils.sh

# Tasks that need to be done once, after Tmux starts.
# Should be executed from a single pane

log_info "Running one-time terminal startup tasks that require user interaction"

if [[ -n "$IS_WSL" ]]; then
	# Fixes:
	# run-detectors: unable to find an interpreter for
	# /mnt/c/Users/username/AppData/Local/Programs/Microsoft VS Code/Code.exe
	sudo update-binfmts --disable cli
fi
