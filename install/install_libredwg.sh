#!/usr/bin/env bash
set -euo pipefail

# Ask for sudo once at the beginning
if ! sudo -v; then
  echo "This script requires sudo privileges."
  exit 1
fi

# Variables — adjust if needed
REPO_URL="https://github.com/LibreDWG/libredwg.git"
CLONE_DIR="$HOME/libredwg"
PREFIX="/usr/local"         # installation prefix
JOBS="$(nproc)"             # parallel make jobs

# Install build dependencies
sudo apt update
sudo apt install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    gcc \
    clang \
    pslib-dev \
    libpcre2-dev \
    cmake \
    ninja-build \
    python3-dev \
    libxml2-dev \
    swig \
    doxygen \
    jq \
    texinfo \
    perl

# Clone the repository (or update if already exists)
if [ ! -d "$CLONE_DIR" ]; then
    git clone "$REPO_URL" "$CLONE_DIR"
else
    echo "Directory $CLONE_DIR exists — pulling latest"
    git -C "$CLONE_DIR" pull
fi

cd "$CLONE_DIR"

# Bootstrap / autogen (only when building from git)
if [ -f ./autogen.sh ]; then
    ./autogen.sh
fi

# Configure with optional features
if ! ./configure \
    --prefix="$PREFIX" \
    --enable-release \
    --enable-trace \
     --disable-python; then
  echo "configure failed"
  exit 1
fi

# Build
make -j "$JOBS"

# (Optional) Run tests
if make check; then
    echo "Tests passed"
else
    echo "WARNING: Some tests failed" >&2
fi

# Install to PREFIX
sudo make install

# Update library cache
sudo ldconfig

echo "LibreDWG installed to $PREFIX"
