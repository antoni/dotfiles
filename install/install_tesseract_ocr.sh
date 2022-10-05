#!/usr/bin/env bash
set -ue

sudo add-apt-repository -y ppa:alex-p/tesseract-ocr5
sudo apt install -y tesseract-ocr tesseract-ocr-pol
tesseract --version
