#!/usr/bin/env bash

wget -qO - terraform.gpg https://apt.releases.hashicorp.com/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/terraform-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/terraform-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/terraform.list
sudo apt update
sudo apt install terraform

# Fix ~/.gnupg ownership
sudo gpgconf --kill dirmngr
sudo chown -R "$USER" ~/.gnupg

# TFlint
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
