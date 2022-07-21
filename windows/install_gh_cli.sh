#!/usr/bin/env bash

# Ubuntu 20
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update

sudo apt install gh

echo Y | gh auth login --hostname github.com --git-protocol https --web
