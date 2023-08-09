#!/usr/bin/env bash

# Steps to build and install tmux from source on Ubuntu.
# Takes < 25 seconds on EC2 env [even on a low-end config instance].
VERSION="3.3a"
sudo apt-get --assume-yes remove tmux
sudo apt-get --assume-yes install wget tar libevent-dev libncurses-dev
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
tar xf tmux-${VERSION}.tar.gz
rm -f tmux-${VERSION}.tar.gz
cd tmux-${VERSION} || exit
./configure
make
sudo make install
cd - || exit
sudo rm -rf /usr/local/src/tmux-*
sudo mv tmux-${VERSION} /usr/local/src

## Logout and login to the shell again and run.
## tmux -V
