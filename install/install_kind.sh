#!/usr/bin/env bash

# https://community.datastax.com/questions/5369/how-do-i-setup-kind-on-ubuntu-to-run-the-kubernete.html

sudo curl -L "https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64" -o /usr/local/bin/kind
sudo chmod +x /usr/local/bin/kind
kind get clusters

