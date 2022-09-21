#!/usr/bin/env bash

sudo add-apt-repository -y ppa:alex-p/tesseract-ocr5
sudo apt install -y tesseract-ocr
tesseract --version
