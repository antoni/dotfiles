#!/usr/bin/env bash

# Applies various fixes to make WSL work 100% correctly

# Fixes: systemd
# https://github.com/microsoft/WSL/issues/8952#issuecomment-1572193568
sudo sh -c 'echo :WSLInterop:M::MZ::/init:PF > /usr/lib/binfmt.d/WSLInterop.conf'
sudo systemctl unmask systemd-binfmt.service
sudo systemctl restart systemd-binfmt
sudo systemctl mask systemd-binfmt.service

# Fixes:
# run-detectors: unable to find an interpreter for
# /mnt/c/Users/username/AppData/Local/Programs/Microsoft VS Code/Code.exe
sudo update-binfmts --disable cli

# Fixes: time inside WSL
# Get the latest time from your Windows machine’s RTC and set the system time to that
sudo hwclock --hctosys
