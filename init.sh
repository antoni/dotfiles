#!/usr/bin/env bash

cd ~ || exit

printf 'Disabling macOS Gatekeeper (temporarily)\n'
spctl --master-disable

#

# Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# git

brew install git grep

# ssh-keygen

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

# copy generated SSH key

printf "Copied SSH key to clipboard"
cat ~/.ssh/id_rsa.pub | pbcopy

printf "Login to Github and paste the SSH key:\n\nhttps://github.com/settings/ssh/new\n\n"

git clone git@github.com:antoni/dotfiles.git
cd dotfiles || exit

# Clone scripts repository

git clone git@github.com:antoni/scripts.git ~/scripts

# Install xCode (TODO)

# Install everything else we need

./install/install.sh

#

# Set deafult browser

defbro com.google.Chrome

# VSCode settings sync

printf 'You need to configure VSCode settings sync manually ("Turn on Settings sync")'

# XX

printf 'Login to Github using (Github CLI)'

gh auth login

# Githu NPM registry login

printf 'Login to Github NPM registry'

npm config set registry https://npm.pkg.github.com/
npm login --registry=https://npm.pkg.github.com/

printf 'Enabling back macOS Gatekeeper\n'
spctl --master-disable
