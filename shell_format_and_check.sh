#!/usr/bin/env bash

# Prepend text at the beginning of each line
function prepend() { while read line; do echo "${1}${line}"; done; }

# Files that are not recognized as shell by shfmt
shell_files="paths
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

ALL_FILES=$(printf "$shell_files" "$(shfmt -f .)" | sort -u)

# Format code
printf "$ALL_FILES" | xargs shfmt -l -w

# Lint code
printf "$ALL_FILES" | xargs shellcheck -f diff | git apply --allow-empty