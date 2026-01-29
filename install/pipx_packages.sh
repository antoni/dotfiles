#!/usr/bin/env bash

PIPX_PACKAGES=(
	pylint pyflakes autopep8 pep8
	pgcli mycli awscli speedtest-cli
	jupyter jupyterlab dl_coursera
	pirate-get virtualenv haruhi-dl
	tdmgr poetry beautysh
	pipupgrade shodan linode-cli mvt
	truffleHog gallery-dl instaloader
	git-filter-repo oci-cli csvkit
	markitdown docling marker-pdf langflow
	xmldiff yq 2to3 "pg_activity[psycopg]" csvkit
)

# TODO: Use this in the install.sh
# Run install_python3.12.sh before
function install_pipx_packages() {
	for pkg in "${PIPX_PACKAGES[@]}"; do
		pipx install --include-deps --force "$pkg"
	done
}

