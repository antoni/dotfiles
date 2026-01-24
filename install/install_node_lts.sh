#!/usr/bin/env bash
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/install_global_javascript_npm_packages.sh"

# Remove system Node leftovers we don't want
sudo apt --assume-yes remove libnode72 nodejs npm || true

echo "▶ Installing nvm..."
export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
	curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load nvm into current shell
if [ -s "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh"
else
	echo "❌ nvm not found after installation"
	exit 1
fi

echo "▶ Installing latest Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

NODE_VERSION="$(node --version)"
NODE_MAJOR_VERSION="${NODE_VERSION#v}"
NODE_MAJOR_VERSION="${NODE_MAJOR_VERSION%%.*}"

echo "Detected Node.js LTS: ${NODE_VERSION} (major: ${NODE_MAJOR_VERSION})"

echo "▶ Enabling Corepack..."
corepack enable

echo "▶ Installing latest Yarn (Berry)..."
corepack prepare yarn@stable --activate

echo "✅ Installation complete"
echo "Node: $(node --version)"
echo "npm:  $(npm --version)"
echo "Yarn: $(yarn --version)"
