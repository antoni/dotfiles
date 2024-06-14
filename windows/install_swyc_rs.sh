#!/usr/bin/env bash

function install_swyh_rs() {
	local -r version_latest="$(gh release list --repo dheijl/swyh-rs --json "isLatest,tagName" | jq --raw-output -c '.[] | select(.isLatest == true).tagName')"
	local -r install_directory="/mnt/c/Users/$WINDOWS_USERNAME"
	local -r release_zip_file=swyh-rs-release.zip

	printf "Downloading swyh-rs version %s\n" "$version_latest"

	pushd "$install_directory" &>/dev/null || return 1

	wget --quiet --progress=bar:force:noscroll "https://github.com/dheijl/swyh-rs/releases/download/$version_latest/swyh-rs-release.zip"
	# Unzip with overwrite
	unzip -qq -o "$release_zip_file"
	rm "$release_zip_file"

	popd &>/dev/null || return 1
}
install_swyh_rs
