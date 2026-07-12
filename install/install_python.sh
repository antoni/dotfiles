#!/usr/bin/env bash
set -euo pipefail

main() {
    # Update package index only once
    sudo apt update -qq

    # Install prerequisites (apt skips already-installed packages)
    sudo apt install -y \
        software-properties-common \
        curl

    # Add deadsnakes PPA only if it doesn't already exist
    if ! grep -Rqs "^deb .*deadsnakes/ppa" /etc/apt/sources.list /etc/apt/sources.list.d 2>/dev/null; then
        sudo add-apt-repository -y ppa:deadsnakes/ppa
        sudo apt update -qq
    fi

    # Install Python 3.12 packages (safe to run repeatedly)
    sudo apt install -y \
        python3.12 \
        python3.12-venv \
        python3.12-dev \
        python3.12-full \
        pipx

    # Ensure pipx is available
    if ! command -v pipx >/dev/null 2>&1; then
        echo "pipx is not on PATH. Try opening a new shell."
        exit 1
    fi

    # Upgrade pipx only if installed via pip
    if python3 -m pip show pipx >/dev/null 2>&1; then
        python3 -m pip install --user --upgrade pipx
    fi

    # Ensure ~/.local/bin is on PATH (safe to run multiple times)
    pipx ensurepath >/dev/null

    # Install Poetry only if it isn't already installed
    if ! pipx list --short 2>/dev/null | grep -qx poetry; then
        pipx install poetry
    fi

    echo
    echo "Python 3.12 installed: $(python3.12 --version)"
    echo "System python3 remains: $(python3 --version)"

    if command -v poetry >/dev/null 2>&1; then
        echo "Poetry: $(poetry --version)"
    fi

    echo
    echo "Create a virtual environment with:"
    echo "  python3.12 -m venv .venv"
    echo "  source .venv/bin/activate"
}

main "$@"