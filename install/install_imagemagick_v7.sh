#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Change to the user's tmp directory
cd "$HOME/tmp"

# Update and upgrade the system
sudo apt-get --quiet update && sudo apt-get --quiet upgrade --yes

# Install required dependencies
sudo apt-get --yes install build-essential libtool libjpeg-dev libpng-dev libtiff-dev libgif-dev libx11-dev libxext-dev libxml2-dev libbz2-dev libz-dev libfontconfig1-dev libfreetype6-dev

# Install optional dependencies (adjust as needed)
sudo apt-get --yes install ghostscript libwebp-dev liblqr-1-0-dev libopenexr-dev libheif-dev libraw-dev

# Define the ImageMagick version
IMAGEMAGICK_VERSION="7.1.1-14"

# Download the ImageMagick source code
wget --quiet "https://download.imagemagick.org/ImageMagick/download/releases/ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"

# Extract the downloaded archive
tar --extract --file="ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"

# Change directory to the extracted folder
cd "ImageMagick-$IMAGEMAGICK_VERSION"

# Configure, compile, and install
./configure
make
sudo make install

# Update shared libraries cache
sudo ldconfig

# Verify installation
magick --version

# Clean up
cd ..
rm --recursive --force "ImageMagick-$IMAGEMAGICK_VERSION" "ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"

echo "ImageMagick $IMAGEMAGICK_VERSION installed successfully!"
