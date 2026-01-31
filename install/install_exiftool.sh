#!/usr/bin/env bash

set -e  # exit on first error

# Variables
URL="https://sourceforge.net/projects/exiftool/files/Image-ExifTool-13.47.tar.gz/download"
TARFILE="Image-ExifTool-13.47.tar.gz"
DIR="Image-ExifTool-13.47"

echo "Downloading ExifTool 13.47..."
wget -O "$TARFILE" "$URL"

echo "Extracting archive..."
tar -xzf "$TARFILE"

cd "$DIR"

echo "Building and installing ExifTool..."
# Perl Makefile.PL and build
perl Makefile.PL
make
sudo make install

echo ""
echo "ExifTool 13.47 installed successfully!"
echo "You can run it with: exiftool"
