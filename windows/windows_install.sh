#!/usr/bin/env bash

# Install Yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

nvm install --lts
nvm install node

# Disable yarn telemetry
yarn config set --home enableTelemetry 0
