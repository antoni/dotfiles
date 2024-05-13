#!/usr/bin/env bash

function install_swyh_rs() {
  local -r version="1.10.5"
  local -r install_directory="/mnt/c/Users/$WINDOWS_USERNAME"
  local -r release_zip_file=swyh-rs-release.zip

  pushd "$install_directory"

  wget --quiet --progress=bar:force:noscroll "https://github.com/dheijl/swyh-rs/releases/download/$version/swyh-rs-release.zip"
  # Unzip with overwrite
  unzip -o "$release_zip_file"
  rm "$release_zip_file"

  popd
}
install_swyh_rs
