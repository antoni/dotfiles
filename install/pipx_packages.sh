#!/usr/bin/env bash

PIPX_PACKAGES=(
	pylint pyflakes autopep8 pycodestyle
	pgcli mycli awscli speedtest-cli
	jupyter jupyterlab dl_coursera
	pirate-get virtualenv haruhi-dl
	tdmgr poetry beautysh
	pipupgrade shodan linode-cli mvt
	trufflehog gallery-dl instaloader
	git-filter-repo oci-cli csvkit
	markitdown docling marker-pdf langflow
	xmldiff yq "pg_activity[psycopg]"
	openai-whisper
)

# TODO: Use this in the install.sh
# Run install_python3.12.sh before
function install_pipx_packages() {
	for pkg in "${PIPX_PACKAGES[@]}"; do
		pipx install --quiet "$pkg"
	done
}

