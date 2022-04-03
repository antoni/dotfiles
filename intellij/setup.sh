#!/bin/bash

declare -a names=("idea-IU-172.3544.35/" "idea-IU-172.4343.14")

for name in "${names[@]}"; do
	mkdir -p ~/."$name"

	if [[ ! -e ~/.$name/config ]]; then
		ln -s "$HOME"/dotfiles/intellij/config ~/."$name"/config
	fi
done
