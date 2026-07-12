#!/usr/bin/env bash

CARGO_CRATES=(yazi-build broot apkeep)

cargo install --locked "${CARGO_CRATES[@]}"
