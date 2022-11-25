#!/usr/bin/env bash

powershell_profile_location=$(wslpath $(powershell.exe -command " Write-Output \$PSHOME"))

cp profile.ps1 $powershell_profile_location
