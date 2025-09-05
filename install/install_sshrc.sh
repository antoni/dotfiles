#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

tmpdir=$(mktemp -d) || {
	echo "Failed to create temp dir"
	exit 1
}
trap 'rm -rf "$tmpdir"' EXIT

cd "$tmpdir" || {
	echo "Failed to cd into temp dir"
	exit 1
}

url="https://raw.githubusercontent.com/cdown/sshrc/master/sshrc"
outfile="sshrc"

if ! wget -q "$url" -O "$outfile"; then
	echo "Download failed: $url"
	exit 1
fi

if ! chmod +x "$outfile"; then
	echo "Failed to chmod $outfile"
	exit 1
fi

if ! sudo mv "$outfile" /usr/local/bin/; then
	echo "Failed to move $outfile to /usr/local/bin"
	exit 1
fi

echo "✅ sshrc installed successfully to /usr/local/bin"

function symlink_sshrc_dotfiles() {
mkdir -p "$HOME/.sshrc.d/dotfiles"
ln -fs "$HOME/dotfiles/utils.sh" "$HOME/.sshrc.d/dotfiles/utils.sh"
ln -fs "$HOME/dotfiles/config.sh" "$HOME/.sshrc.d/dotfiles/config.sh"
ln -fs "$HOME/dotfiles/paths" "$HOME/.sshrc.d/dotfiles/paths"
ln -fs "$HOME/dotfiles/colors.sh" "$HOME/.sshrc.d/dotfiles/colors.sh"
ln -fs "$HOME/dotfiles/format_conversion.sh" "$HOME/.sshrc.d/dotfiles/format_conversion.sh"
ln -fs "$HOME/dotfiles/upgrade_helpers.sh" "$HOME/.sshrc.d/dotfiles/upgrade_helpers.sh"
}
