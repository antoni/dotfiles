#!/usr/bin/env bash

source "$HOME"/dotfiles/utils.sh

DOTFILES_MAC_DIR=$DOTFILES_DIR/mac

function int_signal_handler() {
	printf "\nQuitting... You will have to do cleanup manually\n"
	exit
}

function setup_int_handler() {
	stty -echoctl # hide ^C

	trap int_signal_handler INT
}

setup_int_handler

function custom_sudo_password_read_prompt() {
	# shellcheck disable=SC2154
	echo -en "${colors[BoldGreen]}Enter sudo password:${colors[Reset_Color]}"

	sudo --prompt="" --validate
	clear
}

custom_sudo_password_read_prompt

sudo_keep_alive

# Create temp directory
mkdir -p "$HOME_DIR"/tmp

# Version of clang-format, should be taken from /usr/bin/clang-format-X.Y,
# same for clang-modernize
printf "${colors[Green]}"
CLANG_VERSION=14.0.0
echo "Clang             version symlinked:   " $CLANG_VERSION
CLANG_FORMAT_VERSION=$CLANG_VERSION
CLANG_MODERNIZE_VERSION=$CLANG_VERSION
LLDB_VERSION=3.7
echo "LLDB              version symlinked:   " $LLDB_VERSION
IDEA_VERSION=$(echo "$HOME"/idea-* | awk -F'-' '{print $3}')
echo "IntelliJ          version symlinked:   " "$IDEA_VERSION"
GOGLAND_VERSION=$(echo "$HOME"/Gogland-* | awk -F'-' '{print $2}')
echo "Gogland           version symlinked:   " "$GOGLAND_VERSION"
CLION_VERSION=2017.1.1
echo "CLion             version symlinked:   " $CLION_VERSION
JMETER_VERSION=$(echo "$HOME"/apache-jmeter-* | awk -F'-' '{print $3}')
echo "JMeter            version symlinked:   " "$JMETER_VERSION"
SWEET_HOME_VERSION=$(echo "$HOME"/SweetHome3D-* | awk -F'-' '{print $2}')
echo "SweetHome3D       version symlinked:   " "$SWEET_HOME_VERSION"
echo -e "${colors[Reset_Color]}"

DOTFILES=(profile bashrc zshrc vimrc paths aliases bash_profile common_profile.sh tmux.conf
	gitconfig gitignore gitattributes ghci gvimrc hgrc lldbinit gdbinit xbindkeysrc
	fzf.sh psqlrc colordiffrc emacs inputrc agda sudo_as_admin_successful LESS_TERMCAP
	jupyter newsboat)

function mac_change_hostname() {
	# Fully qualified hostname, for example myMac.domain.com
	sudo scutil --set HostName "$1"
	# Name usable on the local network, for example myMac.local.
	sudo scutil --set LocalHostName "$1"
	# User-friendly computer name you see in Finder, for example myMac.
	sudo scutil --set ComputerName "$1"
}

function gcc_symlink() {
	# these are symlinks, so we can delete these safely
	sudo rm -rf /usr/bin/{gcc,g++}
	sudo ln -s gcc-12 /usr/bin/gcc
	sudo ln -s g++-12 /usr/bin/g++
}

function mac_symlink() {
	ln -sf ~/dotfiles/mac/sleep.sh ~/.sleep
	ln -sf ~/dotfiles/mac/wakeup.sh ~/.wakeup

	function create_symlink_delete_before() {
		local to="$1"
		local from="$2"

		if [[ -L "$from" ]]; then
			printf "symlink '%s' exists, removing\n" "$from"
			rm -rf "$from"
		fi

		ln -s "$to" "$from"
	}

	create_symlink_delete_before \
		"$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
	create_symlink_delete_before \
		"$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
	create_symlink_delete_before \
		"$(brew --prefix llvm)/bin/clang-apply-replacements" "/usr/local/bin/clang-apply-replacements"

	# iTerm2 config
	ln -sf "${DOTFILES_DIR}"/mac/com.googlecode.iterm2.plist \
		~/Library/Preferences/com.googlecode.iterm2.plist

	# Transmission
	"$DOTFILES_MAC_DIR"/transmission.sh

	# ln -sf org.m0k.transmission.plist ~/Library/Preferences/

	# Karabiner config
	ln -fs "$DOTFILES_MAC_DIR"/karabiner ~/.config/

	# TextMate
	rm -rf /usr/local/bin/mate
	sudo ln -s /Applications/TextMate.app/Contents/MacOS/mate /usr/local/bin/mate

	# VLC
	mkdir -p ~/Library/Preferences/org.videolan.vlc
	rm -rf ~/Library/Preferences/org.videolan.vlc/vlcrc
	cp -rf "$DOTFILES_DIR"/vlcrc ~/Library/Preferences/org.videolan.vlc/vlcrc
	# echo "NOTE: When updating preferences, VLC doesn't modify the existing vlcrc, instead it deletes the last and creates a new one. Instead of symlinking, the ~/dotfiles/vlcrc has been copied"

	[ -d "$HOME/scripts" ] && ln -fs ~/scripts/Chrome\ Debugger.app /Applications/
}

# Fedora regular updates
function fedora_regular_updates() {
	sudo dnf install --assumeyes dnf-automatic
	sudo systemctl enable dnf-automatic.timer && systemctl start dnf-automatic.timer
}

# Fedora upgrade
function fedora_system_upgrade() {
	sudo dnf install --assumeyes python3-dnf-plugin-system-upgrade
	sudo dnf system-upgrade download --refresh --releasever=26
	sudo dnf system-upgrade reboot
}

function main() {
	# Symlink the files in the current directory with corresponding dotfiles in
	# the home directory
	for f in "${DOTFILES[@]}"; do
		rm -f ~/."$f"
		ln -sf ~/dotfiles/"$f" ~/."$f" >/dev/null
	done

	# Terminator
	mkdir -p ~/.config/terminator
	ln -fs "${DOTFILES_DIR}"/terminator/config ~/.config/terminator/config

	# irssi
	mkdir -p ~/.irssi
	ln -fs "${DOTFILES_DIR}"/irssi.config ~/.irssi/config

	# Alacritty
	mkdir -p ~/.config/alacritty
	ln -fs "${DOTFILES_DIR}"/alacritty.yml ~/.config/alacritty/alacritty.yml

	# dunst (notifications)
	mkdir -p ~/.config/dunst
	ln -fs "${DOTFILES_DIR}"/dunstrc ~/.config/dunst/dunstrc

	# pgcli
	mkdir -p ~/.config/pgcli
	ln -fs "${DOTFILES_DIR}"/pgcli ~/.config/pgcli/config

	# htop
	mkdir -p ~/.config/htop
	ln -fs "${DOTFILES_DIR}"/htoprc ~/.config/htop/

	# cabal
	mkdir -p ~/.cabal
	ln -fs "${DOTFILES_DIR}"/cabal.config ~/.cabal/config

	# i3-wm
	I3WM_DIR=~/.config/i3/
	if ! [[ -f $I3WM_DIR ]]; then
		mkdir -p $I3WM_DIR
	fi

	ln -fs "${DOTFILES_DIR}"/i3/i3.config ~/.config/i3/config
	ln -fs "${DOTFILES_DIR}"/i3/i3status.config ~/.config/i3/i3status.config

	# Redshift
	if [[ ! -e ~/.config/redshift.conf ]]; then
		mkdir -p ~/.config
		ln -sf "${DOTFILES_DIR}"/redshift.conf ~/.config/redshift.conf
	fi

	# MIME types
	MIME_FILE=$HOME/.config/mimeapps.list
	if [ -e ~/.ssh/id_rsa ]; then
		rm -f "$MIME_FILE"
	fi
	ln -fs "${DOTFILES_DIR}"/config/mimeapps.list "$MIME_FILE"

	# SSH config
	ln -fs "${DOTFILES_DIR}"/sshconfig ~/.ssh/config

	# ~/scripts directory
	function setup_scripts() {
		if [ ! -d "scripts" ]; then
			git clone git@github.com:antoni/scripts.git
		fi
		ln -fs "${DOTFILES_DIR}"/scripts ~/scripts

		# Screenshots
		sudo_exec ln -fs "$HOME"/scripts/st.sh /bin/st
	}

	# setup_scripts

	# .ghci access
	chmod g-w ~/.ghci

	# set -x # echo executed commands

	# /usr/local/bin symlinks
	# Chrome
	sudo_exec ln -fs /usr/bin/google-chrome-stable /usr/local/bin/g
	# Firefox
	# sudo_exec ln -fs /usr/bin/firefox /usr/local/bin/f
	sudo_exec ln -fs "$HOME"/firefox/firefox /usr/local/bin/f
	# Eclipse
	sudo_exec ln -fs ~"$HOME_DIR"/eclipse/eclipse /usr/local/bin/eclipse
	# clang
	sudo_exec ln -fs /usr/bin/clang-$CLANG_VERSION /usr/local/bin/clang
	sudo_exec ln -fs /usr/bin/clang++-$CLANG_VERSION /usr/local/bin/clang++
	# clang-format
	# sudo_exec ln -fs /usr/bin/clang-format-$CLANG_FORMAT_VERSION /usr/local/bin/clang-format
	# clang-modernize
	# sudo_exec ln -fs /usr/bin/clang-modernize-$CLANG_MODERNIZE_VERSION /usr/local/bin/clang-modernize

	# adb
	sudo_exec ln -fs "$HOME_DIR"/Android/Sdk/platform-tools/adb /usr/local/bin/adb

	ln -fs "$HOME_DIR"/dotfiles/antoni.zsh-theme "$HOME_DIR"/.oh-my-zsh/themes

	# python
	sudo_exec ln -fs "$(which python3)" /usr/local/bin/python

	# IDEA
	# sudo_exec mkdir -p /etc/sysctl.d
	# sudo_exec ln -fs "${DOTFILES_DIR}"/intellij/idea_sysctl.conf /etc/sysctl.d/idea_sysctl.conf
	# sudo_exec sysctl -p --system

	# Global aliases
	case "$(uname -s)" in

	Darwin)
		mac_symlink
		;;

	Linux)
		sudo_exec mkdir -p /etc/profile.d
		sudo_exec ln -fs "${DOTFILES_DIR}"/global_aliases /etc/profile.d/global_aliases.sh

		if [[ -n "$IS_WSL" ]]; then
			function replace_notepad_plus_plus_settings() {
				local -r target_path="/mnt/c/Users/""${WINDOWS_USERNAME}""/AppData/Roaming/Notepad++/config.xml"

				printf "Replacing Notepad++ settings at: '%s'\n" "$target_path"

				envsubst <windows/notepad_plus_plus_settings.template.xml >"$target_path"
			}
			replace_notepad_plus_plus_settings

			function symlink_wsl_conf() {
				sudo ln -sf "${DOTFILES_DIR}"/wsl.conf /etc/wsl.conf
			}
			symlink_wsl_conf
		else
			function linux_brightness_settings() {
				sudo cp brightness.sh /root/
				sudo sh -c 'echo "$USER $(hostname) = NOPASSWD: /root/brightness.sh" >> /etc/sudoers'
			}

			linux_brightness_settings

			function linux_xrdb() {
				# Xrdb merge
				XRES_FILE=Xresources.solarized
				xrdb "${DOTFILES_DIR}"/${XRES_FILE}
				ln -sf "${DOTFILES_DIR}"/${XRES_FILE} ~/.Xresources
			}

			linux_xrdb
		fi
		;;
	CYGWIN* | MINGW32* | MSYS* | MINGW*)
		echo 'MS Windows'
		# Note: put only non-WSL things here
		;;
	*)
		echo 'Other OS'
		# See: https://stackoverflow.com/a/27776822/963881
		;;
	esac

	# lldb
	sudo_exec ln -fs /usr/bin/lldb-$LLDB_VERSION /usr/local/bin/lldb
	# IDEA
	sudo_exec ln -fs "$HOME_DIR"/idea-I?-"$IDEA_VERSION"/bin/idea.sh /usr/local/bin/idea
	# Clion
	sudo_exec ln -fs "$HOME_DIR"/clion-$CLION_VERSION/bin/clion.sh /usr/local/bin/clion
	# Gogland
	sudo_exec ln -fs "$HOME_DIR"/Gogland-"$GOGLAND_VERSION"/bin/gogland.sh /usr/local/bin/gogland
	# JMeter
	sudo_exec ln -fs "$HOME_DIR"/apache-jmeter-"$JMETER_VERSION"/bin/jmeter /usr/local/bin/jmeter
	# Robo 3T
	sudo_exec ln -fs "$HOME_DIR"/robo3t-*/bin/robo3t /usr/local/bin/robo3t
	# SweetHome3D
	sudo_exec ln -fs "$HOME_DIR"/SweetHome3D-"$SWEET_HOME_VERSION"/SweetHome3D /usr/local/bin/sweethome

	# Sublime 3
	if [ -e "$HOME"/sublime_text_3 ]; then
		sudo_exec ln -fs "$HOME"/sublime_text_3/sublime_text /usr/local/bin/sublime
	fi

	if [ -e "$HOME"/android-studio ]; then
		sudo_exec ln -fs "$HOME"/android-studio/bin/studio.sh /usr/local//bin/astudio
	fi

	case "$(uname -s)" in
	Darwin)
		ln -fs "${DOTFILES_DIR}"/vscode.json "$HOME"/Library/Application\ Support/Code/User/settings.json
		;;
	Linux)
		ln -fs "${DOTFILES_DIR}"/vscode.json "$HOME"/.config/Code/User/settings.json
		;;
	CYGWIN* | MINGW32* | MSYS*) # MS Windows
		;;
	esac

	set +x # disable echo executed commands

	# Vim

	# (Re)install vim-plug
	curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# Hostname
	function setup_hostname() {
		if [ "${OSTYPE//[0-9.]/}" == "darwin" ]; then
			mac_change_hostname "$HOSTNAME"
		else
			hostnamectl set-hostname "$HOSTNAME"
		fi

		print_success_message "Hostname changed to: $HOSTNAME"
	}

	setup_hostname

	# Midnight Commander
	ln -fs "$DOTFILES_DIR"/mc ~/.config

	# Atom

	mkdir -p "$HOME"/.atom
	pushd atom &>/dev/null || exit 1

	for atom in *; do
		rm -f "$HOME"/.atom/"$atom"
		ln -fs ~/dotfiles/atom/"$atom" "$HOME"/.atom/"$atom"
	done

	popd &>/dev/null || exit 1
	print_success_message "Successfully symlinked all files"

	function find_broken_symlinks() {
		printf "Looking found broken symlinks\n"
		sudo find ~ -type l -maxdepth 3 ! -exec test -e {} \; -print
		sudo find /usr/bin -type l ! -exec test -e {} \; -print
		sudo find /usr/local/bin -type l ! -exec test -e {} \; -print
	}

	find_broken_symlinks
}

main
