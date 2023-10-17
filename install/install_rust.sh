#!/usr/bin/env bash
set -e

# Install Rust toolchain, noninteractively
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source for current session
source "$HOME/.cargo/env"

# Run it, so that we have all components downloaded right away (it does so upon first launch)
cargo --help
