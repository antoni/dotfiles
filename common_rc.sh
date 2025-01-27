#!/usr/bin/env bash

source "$HOME"/dotfiles/config.sh

function export_variables() {
	export DEFAULT_CITY
	export DEFAULT_COORDS
	export GITHUB_USER
	export MACOS_USERNAME
	export WINDOWS_USERNAME
	export WINDOWS_DESKTOP
	export HOMEBREW_NO_AUTO_UPDATE
	export BASH
}
export_variables

source "$HOME"/.paths
# Common profile file for Bash and ZSH
source "$HOME"/.common_profile.sh
source "$HOME"/.fzf.sh

export BUN_INSTALL="/home/antoni/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export GO111MODULE=on

export PGDATA='/usr/local/share/postgres@14'
export PGHOST=localhost

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
