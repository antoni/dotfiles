#!/usr/bin/env bash

set -e

source "$HOME"/dotfiles/config.sh
source "$HOME"/dotfiles/utils.sh

# Ubuntu 22.04, for other versions: https://tailscale.com/download/linux/ubuntu-2204
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

sudo apt-get update
sudo apt-get install -y tailscale

printf "Run \nsudo tailscale up"
