#!/usr/bin/env bash

function setup_textmate_bundles() {
  mkdir ~/Library/Application\ Support/TextMate/Bundles/             
  git clone https://github.com/textmate/haskell.tmbundle.git
}


setup_textmate_bundles
