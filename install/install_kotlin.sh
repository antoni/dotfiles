#!/usr/bin/env bash

set -e

KOTLIN_VERSION="1.9.22"
INSTALL_DIR="$HOME/kotlin"
KOTLIN_ZIP="kotlin-compiler-$KOTLIN_VERSION.zip"
KOTLIN_URL="https://github.com/JetBrains/kotlin/releases/download/v$KOTLIN_VERSION/$KOTLIN_ZIP"

echo "👉 Installing dependencies..."
sudo apt-get update -y && sudo apt-get install -y unzip curl

echo "📦 Downloading Kotlin $KOTLIN_VERSION..."
curl -# -L -o "$KOTLIN_ZIP" "$KOTLIN_URL"

echo "📂 Extracting Kotlin compiler..."
mkdir -p "$INSTALL_DIR"
unzip -q "$KOTLIN_ZIP" -d "$INSTALL_DIR"
rm "$KOTLIN_ZIP"

echo "🛠️  Adding Kotlin to PATH..."
KOTLINC_PATH="$INSTALL_DIR/kotlinc/bin"
if ! grep -q "$KOTLINC_PATH" "$HOME/.bashrc"; then
  echo "export PATH=\"\$PATH:$KOTLINC_PATH\"" >> "$HOME/.bashrc"
  echo "✅ Kotlin path added to .bashrc"
else
  echo "ℹ️ Kotlin path already exists in .bashrc"
fi

echo "✅ Installation complete. Restart your shell or run:"
echo "    export PATH=\"\$PATH:$KOTLINC_PATH\""
echo "    kotlinc -version"
