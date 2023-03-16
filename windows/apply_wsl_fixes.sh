#!/usr/bin/env bash

# Applies various fixes to make WSL work 100% correctly
# Work in progress

# Fixes:
# run-detectors: unable to find an interpreter for /mnt/c/Users/vivob/AppData/Local/Programs/Microsoft VS Code/Code.exe
sudo update-binfmts --disable cli

# Fixes: time inside WSL
# Get the latest time from your Windows machine’s RTC and set the system time to that
# TODO: Move to wsl_fixes.sh (create it)
sudo hwclock --hctosys
