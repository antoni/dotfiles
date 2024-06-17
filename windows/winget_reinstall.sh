#!/usr/bin/env bash

function main() {
	local -r package_name="$1"
	# TODO: Use WINGET_ALIAS and WINGET_COMMAND_INSTALL from winget_package.sh (move to utils.sh first)
	WINGET_ALIAS="winget.exe"
	${WINGET_ALIAS} uninstall -e --id "$package_name"

	WINGET_COMMAND_INSTALL="$WINGET_ALIAS install \
--no-upgrade \
--accept-source-agreements \
--accept-package-agreements \
--exact \
--id "

	${WINGET_COMMAND_INSTALL} "$package_name"
}

main "$@"
