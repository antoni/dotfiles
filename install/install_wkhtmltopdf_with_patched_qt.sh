#!/usr/bin/env bash
set -ue

# There are newer versions of the binary files now. You can alwasy find the latest here:
# https://wkhtmltopdf.org/downloads.html

# Uncomment the next line if you have installed wkhtmltopdf
sudo apt remove -y wkhtmltopdf
cd ~
# Select an appropriate link for your system (32 or 64 bit) from the page https://wkhtmltopdf.org/downloads.html and past to the next line
# wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb
# Ubuntu 22.04 package
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
sudo dpkg -i wkhtmltox_0.12.6.1-2.jammy_amd64.deb
# wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
# tar xvf wkhtmltox*.tar.xz
# sudo mv wkhtmltox/bin/wkhtmlto* /usr/bin
sudo apt-get install -y openssl build-essential libssl-dev libxrender-dev git-core libx11-dev libxext-dev libfontconfig1-dev libfreetype6-dev fontconfig xfonts-75dpi
