#!/usr/bin/env bash

GOLANG_VERSION="1.16.7"

if command_exists go; then
	printf "[${colors[Red]}%s${colors[Reset_Color]}]\n" \
		"golang is already installed"
	exit
fi

function main() {
	pushd ~/tmp || exit
	curl -OL "https://golang.org/dl/go""$GOLANG_VERSION"".linux-amd64.tar.gz"

	echo "Installing Go with the following checksum:"
	sha256sum "go""$GOLANG_VERSION"".linux-amd64.tar.gz"
	sudo tar -C /usr/local -xvf "go""$GOLANG_VERSION"".linux-amd64.tar.gz"

	popd || exit
}

main "$@"
