#!/usr/bin/env bash

source "$(dirname "$0")/../aliases" || exit 1

# 'Current User, All Hosts' location (PowerShell Core)
powershell_profile_directory="/mnt/c/Users/""$WINDOWS_USERNAME""/Documents/PowerShell"

powershell_profile_location=$(printf "%s/Profile.ps1" "$powershell_profile_directory")

mkdir -p "$powershell_profile_directory"

rm --recursive --force "$powershell_profile_location"

cp "$(dirname "$0")"/Microsoft.PowerShell_profile.ps1 "$powershell_profile_location"
