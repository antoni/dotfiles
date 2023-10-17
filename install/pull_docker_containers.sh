#!/usr/bin/env bash
set -e

# Running
# docker run -v ${path_to_host_folder_to_scan}:/gitleaks zricethezav/gitleaks:latest detect --no-banner --source="/gitleaks" --verbose
docker pull zricethezav/gitleaks:latest

docker pull oxsecurity/megalinter:v6
