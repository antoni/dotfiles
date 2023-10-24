#!/usr/bin/env bash

# shellcheck disable=SC2182

source "$HOME"/dotfiles/config.sh

function copy_scripts_to_main_drive() {
    local -r windows_scripts_directory="/mnt/c/scripts"

    printf  "Copying scripts to Windows (host) main drive\n"
    rm -rf "$windows_scripts_directory"

    cp -r "$HOME""/scripts" "$windows_scripts_directory"
}

function main() {
    copy_scripts_to_main_drive

    printf "%s\n" "Run the following PowerShell scripts manually to complete installation process:" \
        "        InstallPowerShell.ps1" \
        "        PostinstallPowerShell.ps1"
}

main "$@"
