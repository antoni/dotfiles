#!/usr/bin/env bash
set -e

# Install required tools
sudo apt update
sudo apt install --assume-yes curl gpg

# Create keyrings directory (standard for 22.04+)
sudo mkdir -p /etc/apt/keyrings

# Add GitHub CLI GPG key
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |
	sudo gpg --dearmor -o /etc/apt/keyrings/githubcli.gpg

# Ensure readable permissions
sudo chmod 644 /etc/apt/keyrings/githubcli.gpg

# Add GitHub CLI repository (Jammy-compatible)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli.gpg] https://cli.github.com/packages stable main" |
	sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

# Install GitHub CLI
sudo apt update
sudo apt install --assume-yes gh

# Authenticate (interactive browser flow)
echo Y | gh auth login --hostname github.com --git-protocol https --web
