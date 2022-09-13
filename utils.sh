#!/usr/bin/env bash

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
	ALL_FILES=$(printf "$unrecognized_shell_files" "$(shfmt --find .)" | sort -u)

	# Format code
	printf "%s" "$ALL_FILES" | xargs shfmt --list --write || exit 1

	# Lint code
	printf "%s" "$ALL_FILES" | xargs shellcheck --external-sources --format diff | git apply --allow-empty || exit 1

	# Run again for files that could not be autofixed
	printf "%s" "$ALL_FILES" | xargs shellcheck --external-sources || exit 1
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

	# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
	while true; do
		sudo --non-interactive true
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &
}
