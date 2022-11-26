#!/usr/bin/env bash

powershell_profile_directory=$(wslpath $(powershell.exe -command " Write-Output \$PSHOME"))
powershell_profile_location=$(printf "%s\/profile.ps1" $powershell_profile_directory)

echo $powershell_profile_directory
# echo $powershell_profile_location

cat profile.ps1 > "$powershell_profile_directory""/profile.ps1"
