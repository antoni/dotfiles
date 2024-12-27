function install_oh_my_zsh() {
	sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
	chsh --shell "$(which zsh)" "$(whoami)" || exit_with_error_message ""

	rm --recursive --force ~/.oh-my-zsh
	curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sh install.sh --unattended
}

function install_zsh_plugins() {
	printf "Installing zsh plugins\n"
	# ZSH_CUSTOM=$HOME/zsh_customizations
	# mkdir -p $ZSH_CUSTOM;
	rm --recursive --force "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions && git clone https://github.com/chrisands/zsh-yarn-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-yarn-completions
	rm --recursive --force "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	rm --recursive --force "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin && git clone https://github.com/unixorn/fzf-zsh-plugin.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-zsh-plugin
	rm --recursive --force "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
}
