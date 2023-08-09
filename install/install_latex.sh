#!/usr/bin/env bash
set -ue

# Install LaTeX on Ubuntu: https://gist.github.com/rain1024/98dd5e2c6c8c28f9ea9d
sudo apt-get install --assume-yes texlive-latex-base
sudo apt-get install --assume-yes texlive-fonts-recommended
sudo apt-get install --assume-yes texlive-fonts-extra
sudo apt-get install --assume-yes texlive-latex-extra
