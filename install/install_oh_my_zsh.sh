#!/usr/bin/env bash

source "$HOME/dotfiles/utils.sh"

function install_zsh_plugins() {
	printf "Installing zsh plugins\n"
	# ZSH_CUSTOM=$HOME/zsh_customizations
	# mkdir -p $ZSH_CUSTOM;
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions && git clone https://github.com/chrisands/zsh-yarn-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin && git clone https://github.com/unixorn/fzf-zsh-plugin.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
}

function symlink_zsh_files() {
	ln -sf ~/dotfiles/zshrc ~/.zshrc
	ln -sf ~/dotfiles/zprofile ~/.zprofile
	ln -fs "$HOME_DIR"/dotfiles/antoni.zsh-theme "$HOME_DIR"/.oh-my-zsh/themes
}

function install_oh_my_zsh() {
	printf "Installing oh-my-zsh\n"
	rm --recursive --force ~/.oh-my-zsh

	# sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
	chsh -s "$(which zsh)" "$(whoami)"

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	install_zsh_plugins
	symlink_zsh_files
}
