#!/usr/bin/env bash
set -e

sudo apt-get install "$(apt-cache search --names-only 'google-cloud-*' | awk -F' - ' '{print $1}')"
