#!/usr/bin/env bash
set -ue

sudo apt-get install "$(apt-cache search --names-only 'google-cloud-*' | awk -F' - ' '{print $1}')"
