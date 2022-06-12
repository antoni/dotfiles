#!/usr/bin/env bash

source "$HOME"/dotfiles/utils.sh

# Files that are not recognized as shell by shfmt
unrecognized_shell_files="paths
aliases
profile
bashrc
paths
aliases
bash_profile
common_profile.sh
optional.sh
fzf.sh
shell_format_and_check.sh
%s" # files found automatically using shfmt

shell_check_and_format "$unrecognized_shell_files"
