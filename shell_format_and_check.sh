#!/usr/bin/env bash

# Files that are not recognized as shell by shfmt
unrecognized_shell_files="paths
aliases
profile
bashrc
paths
aliases
bash_profile
common_profile.sh
fzf.sh
shell_format_and_check.sh"

~/scripts/shell_format_and_check/shell_format_and_check.sh --unrecognized-files "${unrecognized_shell_files//$'\n'/ }" "$HOME"/dotfiles
