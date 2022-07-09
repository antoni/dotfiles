#!/usr/bin/env bash

sudo apt-get install $(apt-cache search --names-only 'google-cloud-*' | awk -F' - ' '{print $1}')
