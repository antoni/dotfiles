#!/usr/bin/env bash

powershell_profile_directory="/mnt/c/Users/vivob/Documents/WindowsPowerShell"
powershell_profile_location=$(printf "%s/Microsoft.PowerShell_profile.ps1" "$powershell_profile_directory")

mkdir -p "$powershell_profile_directory"
rm -rf "$powershell_profile_location"

cp Microsoft.PowerShell_profile.ps1 "$powershell_profile_directory"

cat "$powershell_profile_location"