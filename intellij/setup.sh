#!/bin/bash

declare -a names=("IdeaIC2017.1"
)

for name in "${names[@]}"
do
    mkdir -p ~/.$name

    if [[ ! -a ~/.$name/config ]]
    then
        ln -s $HOME/dotfiles/intellij/config ~/.$name/config
    fi
done


