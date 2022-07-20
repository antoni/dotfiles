#!/usr/bin/env bash

source "$HOME"/.paths
# Common profile file for Bash and ZSH
source "$HOME"/.aliases
source "$HOME"/.common_profile.sh
source "$HOME"/.fzf.sh

export BUN_INSTALL="/home/antoni/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
