#!/usr/bin/env bash
set -e

# Dependencies
sudo apt-get update
sudo apt-get install -y curl gnupg lsb-release ca-certificates

# Create keyrings directory if it doesn't exist
sudo install -m 0755 -d /etc/apt/keyrings

# Download and install HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg |
	sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
	sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null

# Install Packer
sudo apt-get update
sudo apt-get install -y packer
