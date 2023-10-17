#!/usr/bin/env bash
set -e

sudo add-apt-repository --assume-yes ppa:alex-p/tesseract-ocr5
sudo apt install --assume-yes tesseract-ocr tesseract-ocr-pol
tesseract --version
