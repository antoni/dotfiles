#!/usr/bin/env bash

# Exit immediately on error
set -e

# Go to tmp dir
cd "$HOME/tmp"

echo "Updating system..."
sudo apt-get -qq update
sudo apt-get -qq upgrade -y

echo "Installing dependencies..."
sudo apt-get -qq install -y \
  build-essential libtool libjpeg-dev libpng-dev libtiff-dev libgif-dev \
  libx11-dev libxext-dev libxml2-dev libbz2-dev libz-dev \
  libfontconfig1-dev libfreetype6-dev \
  ghostscript libwebp-dev liblqr-1-0-dev libopenexr-dev \
  libheif-dev libraw-dev

IMAGEMAGICK_VERSION="7.1.1-14"
ARCHIVE="ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"
DIR="ImageMagick-$IMAGEMAGICK_VERSION"

echo "Downloading ImageMagick $IMAGEMAGICK_VERSION..."
wget -q "https://download.imagemagick.org/ImageMagick/download/releases/$ARCHIVE"

echo "Extracting..."
tar -xf "$ARCHIVE"

cd "$DIR"

echo "Configuring..."
./configure > configure.log 2>&1

echo "Compiling (this may take a bit)..."
make -j"$(nproc)" > build.log 2>&1

echo "Installing..."
sudo make install > install.log 2>&1

sudo ldconfig

echo "Verifying installation..."
magick --version | head -n 1

cd ..
rm -rf "$DIR" "$ARCHIVE"

echo "✅ ImageMagick $IMAGEMAGICK_VERSION installed successfully"
