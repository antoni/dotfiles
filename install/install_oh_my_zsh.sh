#!/usr/bin/env zsh


export LANG=${LANG:-C.UTF-8}
export LC_ALL=$LANG
export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.oh-my-zsh/cache}"

source "$HOME/dotfiles/utils.sh"

function install_zsh_plugins() {
	printf "Installing zsh plugins in %s\n" "$ZSH_CUSTOM"

	mkdir -p $ZSH_CUSTOM
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions && git clone https://github.com/chrisands/zsh-yarn-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin && git clone https://github.com/unixorn/fzf-zsh-plugin.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin
	rm --recursive --force "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
}

function symlink_zsh_files() {
	printf "Symlinking zsh files\n"
	ln -sf ~/dotfiles/zshrc ~/.zshrc
	ln -sf ~/dotfiles/zprofile ~/.zprofile
	ln -fs "$HOME"/dotfiles/custom.zsh-theme "$HOME"/.oh-my-zsh/themes
}

function install_oh_my_zsh() {
	printf "Installing oh-my-zsh\n"
	rm --recursive --force ~/.oh-my-zsh

	sudo chsh -s "$(which zsh)" "$(whoami)"

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	symlink_zsh_files
	install_zsh_plugins
}

install_oh_my_zsh
