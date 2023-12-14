#!/usr/bin/env bash

source "$HOME"/dotfiles/config.sh

# Install Yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# Install nvm
# https://github.com/nvm-sh/nvm/releases
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

nvm install "$NODE_VERSION"
nvm alias default "$NODE_VERSION"
nvm install node

# Disable yarn telemetry
yarn config set --home enableTelemetry 0
