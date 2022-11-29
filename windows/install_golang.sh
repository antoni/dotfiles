#!/usr/bin/env bash

# TODO: Check if go hasn't been installed via apt

pushd ~/tmp || exit
curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz

echo "Installing Go with the following checksum:"
sha256sum go1.16.7.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz

popd || exit
