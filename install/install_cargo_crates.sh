#!/usr/bin/env bash

CARGO_CRATES=(yazi-build broot apkeep)

# TODO: Confirm we use it in installation process
cargo install --locked "${CARGO_CRATES[@]}"
