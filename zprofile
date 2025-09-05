#!/usr/bin/env bash

source "$HOME"/.common_profile.sh

if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi
