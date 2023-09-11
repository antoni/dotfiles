#!/usr/bin/env bash

# TODO: Pass from command line
GOLANG_VERSION="1.21.1"

source "$HOME"/dotfiles/utils.sh

function install_golang() {
	if command_exists go; then
		printf "${colors[Yellow]}%s${colors[Reset_Color]}\n" \
			"golang is already installed"
		return
	else
		printf "Installing golang version %s...\n" "$GOLANG_VERSION"
		pushd ~/tmp &>/dev/null || exit
		curl -OL --silent "https://golang.org/dl/go""$GOLANG_VERSION"".linux-amd64.tar.gz"

		echo "Installing Go with the following checksum:"
		sha256sum "go""$GOLANG_VERSION"".linux-amd64.tar.gz"
		sudo tar -C /usr/local -xvf "go""$GOLANG_VERSION"".linux-amd64.tar.gz"

		popd &>/dev/null || exit
	fi
}

# TODO: Add it to install script
function install_go_packages() {
	if command_exists go; then
		GO_PACKAGES=(github.com/derekparker/delve/cmd/dlv github.com/Sirupsen/logrus
			github.com/mvdan/sh/cmd/shfmt github.com/tomnomnom/gron
			github.com/rverton/webanalyze/cmd/webanalyze mvdan.cc/sh/v3/cmd/shfmt)

		# shellcheck disable=2048
		for package in ${GO_PACKAGES[*]}; do
			go install "$package""@latest"
		done
	else
		printf "${colors[Red]}%s${colors[Reset_Color]}\n" \
			"golang is not installed. Exiting"
		# TODO: Exit with error
	fi
}

# TODO: Test this
function main() {
	if install_golang; then
		install_go_packages
	fi
}

main "$@"
