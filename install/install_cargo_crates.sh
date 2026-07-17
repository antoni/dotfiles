#!/usr/bin/env bash

CARGO_CRATES=(yazi-build broot apkeep mbtiles)

cargo install --locked "${CARGO_CRATES[@]}"
