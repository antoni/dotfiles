#!/usr/bin/env bash

CARGO_CRATES=(yazi-build broot)

cargo install --locked "${CARGO_CRATES[@]}"
