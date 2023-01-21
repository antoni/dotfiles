#!/usr/bin/env bash

# Install
sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install apt-fast

# Configure

echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections
echo debconf apt-fast/dlflag boolean true | debconf-set-selections
echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections
