#!/usr/bin/env bash

export IS_WSL="${WSL_DISTRO_NAME:-""}"
export DOTFILES_DIR=$HOME/dotfiles

source "$HOME/dotfiles/config.sh"
source "$HOME/dotfiles/paths"
source "$HOME/dotfiles/colors.sh"
source "$HOME/dotfiles/format_conversion.sh"
source "$HOME/dotfiles/upgrade_helpers.sh"

UNAME_OUTPUT="$(uname)"
export UNAME_OUTPUT

function command_exists() { type "$1" &>/dev/null; }

# Example:
# array=("one" "two" "three")
# find_duplicates_in_array "${array[@]}"
function find_duplicates_in_array() {
	local array=("$@")
	printf '%s\n' "${array[@]}" | awk '!($0 in seen){seen[$0];next} 1'
}

function sudo_exec() {
	sudo "$@"
}

function sudo_keep_alive() {
	# Ask for the administrator password upfront
	if ! sudo -n true 2>/dev/null; then
		printf '%b' "${colors[BoldGreen]}Enter sudo password:${colors[Reset_Color]}"
		sudo --prompt="" --validate
	fi

	clear

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
	local message="$1"
	printf "\033[1;29;42m DONE ${colors[Green]} %s${colors[Reset_Color]}\n" \
		"$message"
}

function log_info() {
	local message="$1"
	printf "${colors[Green]}%s${colors[Reset_Color]}\n" \
		"$message"
}

function log_warning() {
	local message="$1"
	printf "${colors[Yellow]}%s${colors[Reset_Color]}\n" \
		"$message"
}

function log_error() {
	local message="$1"
	printf "${colors[Red]}%s${colors[Reset_Color]}\n" \
		"$message"
}

function brew_relink() {
	echo "Relinking all packages"

	brew list -1 | while read -r line; do
		brew unlink "$line" && brew link "$line"
	done
}

function clear_bash_history() {
	cat /dev/null >~/.bash_history && history -c && exit
}

# Windows
function exec_powershell_script() {
	local script_path="$1"

	powershell.exe -NoLogo -ExecutionPolicy Bypass -File "$script_path"
}

# Windows
# Note: run it with 'wslpath -w'
# Ex.:
# powershell.exe -NoLogo -ExecutionPolicy Bypass -command
# "$(wslpath -w ~/scripts/SomeScript.ps1) -param \"val\""
function exec_powershell_command() {
	local script_path="$1"

	# powershell.exe -NoLogo -ExecutionPolicy Bypass -File "$script_path"
	powershell.exe -NoLogo -ExecutionPolicy Bypass -Command "$script_path"
}

function return_with_error_message() {
	local -r error_message="$1"
	printf "${colors[Red]}Error: %s${colors[Reset_Color]}\n" "$error_message"
}

function exit_with_error_message() {
	local -r error_message="$1"
	printf "${colors[Red]}Error: %s${colors[Reset_Color]}\n" "$error_message"

	exit 1
}
