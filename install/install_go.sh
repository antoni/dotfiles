#!/usr/bin/env bash

set -e

source "$HOME"/dotfiles/config.sh
source "$HOME"/dotfiles/utils.sh

function install_go() {
	if command_exists go; then
		printf "${colors[Yellow]}%s${colors[Reset_Color]}\n" \
			"Go is already installed"
	else
		printf "Installing Go version %s...\n" "$GO_VERSION"
		pushd ~/tmp &>/dev/null || return 1
		curl -OL --silent --fail "https://go.dev/dl/go""$GO_VERSION"".linux-amd64.tar.gz" || return 1

		echo "Installing Go with the following checksum:"
		sha256sum "go""$GO_VERSION"".linux-amd64.tar.gz"
		sudo tar --directory /usr/local -xf "go""$GO_VERSION"".linux-amd64.tar.gz" || return 1

		popd &>/dev/null || return 1
	fi
}

function install_go_packages() {
	log_info "Installing go packages"
	if command_exists go; then
		GO_PACKAGES=(
			github.com/ycd/dstp/cmd/dstp
			github.com/charmbracelet/glow
			github.com/tomnomnom/gron
			github.com/rverton/webanalyze/cmd/webanalyze
			mvdan.cc/sh/v3/cmd/shfmt)

		# shellcheck disable=2048
		for package in ${GO_PACKAGES[*]}; do
			go install "$package""@latest"
		done
	else
		printf "${colors[Red]}%s${colors[Reset_Color]}\n" \
			"Go is not installed. Exiting"
		return 1
	fi
}

function main() {
	if ! install_go; then
		log_error "Error installing Go"
	else
		install_go_packages
	fi
}

main "$@"
