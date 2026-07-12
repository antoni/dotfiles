#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

IMAGEMAGICK_VERSION="7.1.2-27"
ARCHIVE="ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"
DIR="ImageMagick-$IMAGEMAGICK_VERSION"

cd "$HOME/tmp"

echo "Updating system..."
sudo apt-get -qq update
sudo apt-get -qq upgrade -y

# Exit early if the requested version is already installed.
if command -v magick >/dev/null 2>&1; then
    INSTALLED_VERSION="$(magick --version | awk 'NR==1 {print $3}')"
    if [[ "$INSTALLED_VERSION" == "$IMAGEMAGICK_VERSION" ]]; then
        echo "ImageMagick $IMAGEMAGICK_VERSION is already installed."
        exit 0
    fi
fi

echo "Checking for distro-installed ImageMagick..."

if command -v magick >/dev/null 2>&1 || command -v convert >/dev/null 2>&1; then
    echo "ImageMagick detected. Removing distro packages..."

    sudo apt-get -qq purge -y \
        imagemagick \
        imagemagick-6-common \
        imagemagick-6.q16 \
        imagemagick-7* \
        'libmagick*6*' \
        'libmagick*7*' || true

    sudo apt-get -qq autoremove --purge -y

    sudo rm -rf /etc/ImageMagick-6 /etc/ImageMagick-7

    echo "Existing ImageMagick packages removed."
else
    echo "No distro-installed ImageMagick found."
fi

echo "Installing dependencies..."
sudo apt-get -qq install -y \
  build-essential libtool libjpeg-dev libpng-dev libtiff-dev libgif-dev \
  libx11-dev libxext-dev libxml2-dev libbz2-dev libz-dev \
  libfontconfig1-dev libfreetype6-dev \
  ghostscript libwebp-dev liblqr-1-0-dev libopenexr-dev \
  libheif-dev libraw-dev

echo "Cleaning previous build artifacts..."
rm -rf "$DIR" "$ARCHIVE"

echo "Downloading ImageMagick $IMAGEMAGICK_VERSION..."
echo "https://download.imagemagick.org/archive/$ARCHIVE"
wget --https-only -O "$ARCHIVE" \
    "https://download.imagemagick.org/archive/$ARCHIVE"

echo "Extracting..."
tar -xf "$ARCHIVE"

cd "$DIR"

echo "Configuring..."
./configure >configure.log 2>&1

echo "Compiling (this may take a bit)..."
make -j"$(nproc)" >build.log 2>&1

echo "Installing..."
sudo make install >install.log 2>&1

sudo ldconfig

echo "Verifying installation..."
magick --version | head -n 1

cd ..
rm -rf "$DIR" "$ARCHIVE"

echo "✅ ImageMagick $IMAGEMAGICK_VERSION installed successfully"