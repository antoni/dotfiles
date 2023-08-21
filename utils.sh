#!/usr/bin/env bash

export IS_WSL="${WSL_DISTRO_NAME:-""}"
export HOME_DIR=$HOME
export DOTFILES_DIR=$HOME_DIR/dotfiles

source "$DOTFILES_DIR"/colors.sh
source "$DOTFILES_DIR"/format_conversion.sh

UNAME_OUTPUT="$(uname)"
export UNAME_OUTPUT

# Example:
# array=("one" "two" "three")
# find_duplicates_in_array "${array[@]}"
function find_duplicates_in_array() {
	local array=("$@")
	printf '%s\n' "${array[@]}" | awk '!($0 in seen){seen[$0];next} 1'
}

function shell_check_and_format() {
	local unrecognized_shell_files=$1

	# shellcheck disable=SC2059
	ALL_FILES=$(printf "%s\n%s" "$unrecognized_shell_files" "$(shfmt --find .)" | sed 's/ /\\\ /g' | sort -u)

	# echo $ALL_FILES[*]
	# shfmt --find . | sed 's/ /\\\ /g'

	# Format code
	printf "%s" "$ALL_FILES" | xargs shfmt --list --write || exit 1

	# Lint code
	# printf "%s" "$ALL_FILES" | xargs shellcheck --external-sources --format diff | git apply --allow-empty || exit 1

	# Run again for files that could not be autofixed
	# printf "%s" "$ALL_FILES" | xargs shellcheck --external-sources || exit 1
}

function sudo_exec() {
	sudo "$@"
}

function sudo_keep_alive() {
	# Ask for the administrator password upfront
	sudo -v

	# kill -0 PID exits with an exit code of 0 if the PID is of
	# a running process, otherwise exits with an exit code of 1.
	# So, basically, kill -0 "$$" || exit aborts the while loop child process
	# as soon as the parent process is no longer running

	# Keep-alive: update existing `sudo` time stamp until process has finished
	while true; do
		sudo --non-interactive true
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &
}

function generate_ssh_key() {
	if [ ! -e ~/.ssh/id_rsa ]; then
		ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
	else
		printf "SSH key already at ~/.ssh/id_rsa. Not creating one\n"
	fi
}

function filename_without_extension() {
	local full_path=$1
	filename=$(basename -- "$full_path")
	extension=$([[ "$filename" = *.* ]] && echo ".${filename##*.}" || echo '')
	filename="${filename%.*}"
	echo "$filename"
}

function filename_extension() {
	local extension="${1##*.}"
	echo "$extension"
}

function date_plus_days() {
	local -r dd="$1"
	local -r plus_days="$2"

	local -r days_add_string=$(printf "%s+%s days" "$dd" "$plus_days")

	if [[ $(gdate -d "$dd" "+%Y-%m-%d") == "$dd" ]]; then
		gdate -d "$days_add_string" "+%Y-%m-%d"
	else
		echo 'Invalid date format'
		return 1
	fi
}

function print_success_message() {
	local message=$1
	echo -e "\033[1;29;42m DONE \033[0m \033[1;32m $1 \033[0m"
	echo -e "${colors[Reset_Color]}"
}
