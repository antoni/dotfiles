#!/usr/bin/env bash
set -euo pipefail

main() {
    # Ensure add-apt-repository is available
    sudo apt update
    sudo apt install -y \
        software-properties-common \
        curl

    # Add deadsnakes PPA
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt update

    # Install Python 3.12 and tooling
    sudo apt install -y \
        python3.12 \
        python3.12-venv \
        python3.12-dev \
        python3.12-full

    # Do NOT install python3.10-venv.
    # Keep the system Python untouched, but use Python 3.12 for projects.

    # Install pipx from Ubuntu packages
    sudo apt install -y pipx

    # Ensure ~/.local/bin is on PATH
    pipx ensurepath

    # Install Poetry via pipx
    if ! command -v poetry >/dev/null 2>&1; then
        pipx install poetry
    fi

    echo "Python 3.12 installed: $(python3.12 --version)"
    echo "System python3 remains: $(python3 --version)"
    echo
    echo "Create a virtual environment with:"
    echo "  python3.12 -m venv .venv"
    echo "  source .venv/bin/activate"
}

main "$@"