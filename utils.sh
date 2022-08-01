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
	sudo $@
}
