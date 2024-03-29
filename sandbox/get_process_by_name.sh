#!/usr/bin/env bash

# shellcheck disable=SC1001

# Windows only
function get_process_by_name() {
	local process_name="$1"
	process_list=$(
		powershell.exe -NoLogo -Command Get-Process \| Where \{\$\_.ProcessName -Like \"*"$process_name"*\"\}
		echo unformatted_output
	)
	echo "${process_list%unformatted_output}" | head --lines=-2 | tail -n +4
}

get_process_by_name winlogon
