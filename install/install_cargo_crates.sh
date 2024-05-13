#!/usr/bin/env bash

CARGO_CRATES=(yazi-fm yazi-cli)

cargo install --locked "${CARGO_CRATES[@]}"
