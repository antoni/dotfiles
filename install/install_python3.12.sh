#!/usr/bin/env bash
set -euo pipefail

main() {
	# Ensure add-apt-repository is available (runs under system python3.10)
	sudo apt update
	sudo apt install -y software-properties-common curl

	# Add deadsnakes PPA
	sudo add-apt-repository ppa:deadsnakes/ppa -y
	sudo apt update

	# Install Python 3.12 and common extras
	sudo apt install -y python3.12 python3.12-venv python3.12-dev python3.12-full

  # TODO: Fix this, make sure we have 3.12 only
	sudo apt install python3.10-venv

	# TODO: Decide which is correct
	sudo apt install python3-pip
	# Install pip for Python 3.12
	# curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3.12

	# Install pipx (system default 3.10), then ensure PATH
	python3 -m pip uninstall -y pipx
	python3 -m pip install --user pipx

	pipx ensurepath

	# TODO: Fix this step
	# Install Poetry with pipx
	# pipx install poetry

	echo "✅ Python 3.12 installed as /usr/bin/python3.12"
	echo "System python3 is $(python3 --version) (kept at 3.10 for APT)."
}

main "$@"
