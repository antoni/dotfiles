#!/usr/bin/env bash
set -euo pipefail

main() {
    # On macOS, Chrome is installed via Homebrew.
    if [[ "$UNAME_OUTPUT" == "Darwin" ]]; then
        return
    fi

    # Google Chrome for Linux is only available on amd64.
    if [[ "$(dpkg --print-architecture)" != "amd64" ]]; then
        echo "Google Chrome is only available for amd64."
        exit 1
    fi

    # Ensure required tools exist.
    sudo apt-get update --quiet=2
    sudo apt-get install --assume-yes wget gnupg

    # Create keyring directory if needed.
    sudo install -d -m 0755 /etc/apt/keyrings

    # Install Google's signing key if it isn't already present.
    if [[ ! -f /etc/apt/keyrings/google-chrome.gpg ]]; then
        wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
            | gpg --dearmor \
            | sudo tee /etc/apt/keyrings/google-chrome.gpg >/dev/null
        sudo chmod 644 /etc/apt/keyrings/google-chrome.gpg
    fi

    # Configure the Chrome repository.
    sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null <<EOF
deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main
EOF

    # Install Chrome.
    sudo apt-get update --quiet=2
    sudo apt-get install --assume-yes google-chrome-stable
}

main "$@"