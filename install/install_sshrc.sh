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
