#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Checking for system-installed Rust..."

# Try to detect and remove Rust installed via APT or Snap
if command -v rustc >/dev/null 2>&1; then
	rustc_path=$(command -v rustc)

	# Detect APT-installed rustc
	if dpkg -S "$rustc_path" 2>/dev/null | grep -q "^rust"; then
		echo "🧹 Removing Rust installed via APT..."
		sudo apt remove --purge -y rustc cargo
	fi

	# Detect Snap-installed rustc
	if snap list 2>/dev/null | grep -q "^rust"; then
		echo "🧹 Removing Rust installed via Snap..."
		sudo snap remove rustup rustc cargo || true
	fi

	# If still exists in a system path, forcibly remove
	if [[ "$rustc_path" != "$HOME/.cargo/bin/rustc" ]]; then
		echo "⚠️ Removing stray system rustc at: $rustc_path"
		sudo rm -f "$rustc_path"
	fi
fi

# Check again if rustc is still in system path (not via rustup)
if command -v rustc >/dev/null 2>&1 && [[ "$(command -v rustc)" != "$HOME/.cargo/bin/rustc" ]]; then
	echo "❌ System-wide rustc still present at $(command -v rustc). Please remove it manually."
	exit 1
fi

echo "✅ No conflicting system Rust found."

# Install rustup if missing
if ! command -v rustup >/dev/null 2>&1; then
	echo "⬇️ Installing rustup..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source "$HOME/.cargo/env"
fi

# Ensure environment is sourced
source "$HOME/.cargo/env"

# Set default toolchain if none configured
if ! rustup show active-toolchain >/dev/null 2>&1; then
	echo "🔧 Setting default toolchain to stable..."
	rustup default stable
fi

# Get installed version via rustup
installed_version=$(rustup show active-toolchain | awk '{print $1}' | cut -d'-' -f1)

# Get latest stable version from rust's channel metadata
latest_version=$(curl -s https://static.rust-lang.org/dist/channel-rust-stable.toml |
	grep '^version =' | head -n1 | cut -d'"' -f2)

echo "🧾 Installed Rust version: $installed_version"
echo "📦 Latest stable version: $latest_version"

# Reinstall if outdated
if [ "$installed_version" != "$latest_version" ]; then
	echo "🔁 Rust is outdated. Reinstalling clean..."
	rustup self uninstall -y
	rm -rf "$HOME/.cargo" "$HOME/.rustup"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source "$HOME/.cargo/env"
	rustup default stable
else
	echo "✅ Rust is up to date."
fi

echo ""
echo "🎉 Rust setup complete!"
rustc --version
cargo --version
