#!/usr/bin/env bash

#!/bin/bash

# Script to install Bitwarden CLI on Ubuntu, working from $HOME/tmp

# Function to display a message and exit on error
function error_exit {
    echo "Error: $1"
    exit 1
}

# Set temporary working directory
TMP_DIR="$HOME/tmp"
mkdir -p "$TMP_DIR" || error_exit "Failed to create temporary directory."

# Navigate to the temporary directory
cd "$TMP_DIR" || error_exit "Failed to change to temporary directory."

echo "Updating system..."
sudo apt update && sudo apt upgrade -y || error_exit "Failed to update system."

echo "Installing prerequisites..."
sudo apt install curl unzip -y || error_exit "Failed to install prerequisites."

echo "Downloading Bitwarden CLI..."
curl -Lso bw.zip "https://vault.bitwarden.com/download/?app=cli&platform=linux" || error_exit "Failed to download Bitwarden CLI."

echo "Extracting Bitwarden CLI..."
mkdir -p ~/.local/bin || error_exit "Failed to create bin directory."
unzip -o bw.zip -d ~/.local/bin || error_exit "Failed to extract Bitwarden CLI."
chmod +x ~/.local/bin/bw || error_exit "Failed to make Bitwarden CLI executable."

echo "Cleaning up..."
rm -f bw.zip || error_exit "Failed to remove temporary files."

# Add ~/.local/bin to PATH if not already present
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "Adding ~/.local/bin to PATH..."
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc || error_exit "Failed to update .bashrc."
    source ~/.bashrc || error_exit "Failed to reload .bashrc."
fi

echo "Verifying Bitwarden CLI installation..."
if command -v bw &> /dev/null; then
    echo "Bitwarden CLI installed successfully!"
    bw --version
else
    error_exit "Bitwarden CLI installation failed."
fi

# Cleanup temporary directory (optional, remove this block if you want to keep tmp dir)
echo "Cleaning up temporary directory..."
rm -rf "$TMP_DIR" || error_exit "Failed to clean up temporary directory."
