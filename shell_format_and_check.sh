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
fzf.sh
shell_format_and_check.sh" # files found automatically using shfmt

shell_check_and_format "$unrecognized_shell_files"

if [ -z "$(docker images -q zricethezav/gitleaks:latest 2>/dev/null)" ]; then
	docker pull ghcr.io/gitleaks/gitleaks:latest
fi

docker run --rm --interactive \
	--volume="$(pwd):/current_repo" \
	--workdir="/current_repo" \
	zricethezav/gitleaks:latest detect \
	--source="/current_repo" \
	--report-path="/dev/stdout" \
	--redact="0" \
	--no-banner
