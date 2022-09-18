#!/usr/bin/env bash

function export_variables() {
	export DEFAULT_CITY="Warsaw"
	export DEFAULT_COORDS="52.23:21.012'"
	export GITHUB_USER="antoni"
	# TODO: Get username dynamically: powershell.exe '$env:UserName'
	# (it takes time, return value should be stored somewhere)
	export WINDOWS_USERNAME="Komputer"
	export HOMEBREW_NO_AUTO_UPDATE=1
	export BASH=/usr/local/bin/bash
}
export_variables

source "$HOME"/.paths
# Common profile file for Bash and ZSH
source "$HOME"/.aliases
source "$HOME"/.common_profile.sh
source "$HOME"/.fzf.sh

export BUN_INSTALL="/home/antoni/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
