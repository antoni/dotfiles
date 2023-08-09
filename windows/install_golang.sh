#!/usr/bin/env bash

if command_exists go; then
	printf "[${colors[Red]}%s${colors[Color_Off]}]\n" \
		"golang is already installed"
	exit
fi

# TODO: Pass golang version from command line
function main() {
	pushd ~/tmp || exit
	curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz

	echo "Installing Go with the following checksum:"
	sha256sum go1.16.7.linux-amd64.tar.gz
	sudo tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz

	popd || exit
}

main "$@"
