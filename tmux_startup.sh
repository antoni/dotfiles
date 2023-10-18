#!/usr/bin/env bash

source "$HOME"/dotfiles/utils.sh

STARTUP_DIRECTORY="$HOME/design-system"

# Tasks that need to be done once, after Tmux starts.
# Should be executed from a single pane

log_info "Running one-time terminal startup tasks that require user interaction"

if [ ! -d "$STARTUP_DIRECTORY" ]; then
	log_warning "$(printf "Startup directory ('%s') does not exist\n" "$STARTUP_DIRECTORY")"
fi

if [[ -n "$IS_WSL" ]]; then
	# Fixes:
	# run-detectors: unable to find an interpreter for
	# /mnt/c/Users/username/AppData/Local/Programs/Microsoft VS Code/Code.exe
	sudo update-binfmts --disable cli
fi
