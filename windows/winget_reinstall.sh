#!/usr/bin/env bash
source "$HOME"/dotfiles/windows/winget_utils.sh

function main() {
	local -r package_name="$1"
	${WINGET_COMMAND_UNINSTALL} "$package_name"
	${WINGET_COMMAND_INSTALL} "$package_name"
}

main "$@"
