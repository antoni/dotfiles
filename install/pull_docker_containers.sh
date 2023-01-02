#!/usr/bin/env bash
set -ue

# Running
# docker run -v ${path_to_host_folder_to_scan}:/path zricethezav/gitleaks:latest [COMMAND] --source="/path" [OPTIONS]
docker pull zricethezav/gitleaks:latest

docker pull oxsecurity/megalinter:v6
