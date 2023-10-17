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

# see: https://github.com/docker/for-win/issues/8336
function fix_zsh_docker_autocompletions() {
  local -r script_directory=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
  sudo cp "$script_directory""/_docker" /usr/share/zsh/vendor-completions/_docker
}

fix_zsh_docker_autocompletions
