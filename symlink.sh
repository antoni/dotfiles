#!/usr/bin/env bash

HOME_DIR=$HOME
DOTFILES_DIR=$HOME_DIR/dotfiles
source $DOTFILES_DIR/colors.sh

function print_success_message() {
	local message=$1
	echo -e "\033[1;29;42m DONE \033[0m \033[1;32m $1 \033[0m"
	echo -e ${colors[Black]}
}

echo -en "${colors[BGreen]}Enter sudo password:${colors[Black]} "
read -s SUDO_PASS
clear

source $DOTFILES_DIR/utils.sh

# Create temp directory
mkdir -p $HOME_DIR/tmp

# Version of clang-format, should be taken from /usr/bin/clang-format-X.Y,
# same for clang-modernize
CLANG_VERSION=3.9
echo "Clang    version symlinked:   " $CLANG_VERSION
CLANG_FORMAT_VERSION=$CLANG_VERSION
CLANG_MODERNIZE_VERSION=$CLANG_VERSION
echo -e "${colors[Green]}"
LLDB_VERSION=3.7
echo "LLDB               version symlinked:   " $LLDB_VERSION
IDEA_VERSION=$(echo $HOME/idea-* | awk -F'-' '{print $3}')
echo "IntelliJ           version symlinked:   " $IDEA_VERSION
GOGLAND_VERSION=$(echo $HOME/Gogland-* | awk -F'-' '{print $2}')
echo "Gogland            version symlinked:   " $GOGLAND_VERSION
CLION_VERSION=2017.1.1
echo "CLion              version symlinked:   " $CLION_VERSION
JMETER_VERSION=$(echo $HOME/apache-jmeter-* | awk -F'-' '{print $3}')
echo "JMeter             version symlinked:   " $JMETER_VERSION
SWEET_HOME_VERSION=$(echo $HOME/SweetHome3D-* | awk -F'-' '{print $2}')
echo "SweetHome3D        version symlinked:   " $SWEET_HOME_VERSION
echo -e "${colors[White]}"

DOTFILES=(profile bashrc zshrc vimrc paths aliases bash_profile common_profile.sh tmux.conf
	gitconfig gitignore ghci gvimrc hgrc lldbinit gdbinit xbindkeysrc
	optional.sh fzf.sh psqlrc colordiffrc emacs inputrc agda
	jupyter newsboat) # Directories

function mac_change_hostname() {
	# Fully qualified hostname, for example myMac.domain.com
	sudo scutil --set HostName $1
	# Name usable on the local network, for example myMac.local.
	sudo scutil --set LocalHostName $1
	# User-friendly computer name you see in Finder, for example myMac.
	sudo scutil --set ComputerName $1
}

function mac_symlink() {
	ln -sf ~/dotfiles/mac/sleep.sh ~/.sleep
	ln -sf ~/dotfiles/mac/wakeup.sh ~/.wakeup

	# iTerm2 config
	ln -sf ${DOTFILES_DIR}/com.googlecode.iterm2.plist \
		~/Library/Preferences/com.googlecode.iterm2.plist

	# Transmission
	ln -sf org.m0k.transmission.plist ~/Library/Preferences/

	# TextMate
	sudo ln -fs /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate

	# VLC
	mkdir -p ~/Library/Preferences/org.videolan.vlc
	cp -f ${DOTFILES_DIR}/vlcrc ~/Library/Preferences/org.videolan.vlc/vlcrc
	echo "NOTE: When updating preferences, VLC doesn't modify the existing vlcrc, instead it deletes the last and creates a new one. Instead of symlinking, the ~/dotfiles/vlcrc has been copied"

	[ -d "~/scripts" ] && ln -fs ~/scripts/Chrome\ Debugger.app /Applications/
}

# TODO: Use it in Linux section
function linux_xrdb() {
	# Xrdb merge
	XRES_FILE=Xresources.solarized
	xrdb ${DOTFILES_DIR}/${XRES_FILE}
	ln -sf ${DOTFILES_DIR}/${XRES_FILE} ~/.Xresources
}

# Symlink the files in the current directory with corresponding dotfiles in
# the home directory
for f in "${DOTFILES[@]}"; do
	rm -f ~/.$f
	ln -sf ~/dotfiles/$f ~/.$f >/dev/null
done

# Terminator
mkdir -p ~/.config/terminator
ln -fs ${DOTFILES_DIR}/terminator/config ~/.config/terminator/config

# irssi
mkdir -p ~/.irssi
ln -fs ${DOTFILES_DIR}/irssi.config ~/.irssi/config

# Alacritty
mkdir -p ~/.config/alacritty
ln -fs ${DOTFILES_DIR}/alacritty.yml ~/.config/alacritty/alacritty.yml

# dunst (notifications)
mkdir -p ~/.config/dunst
ln -fs ${DOTFILES_DIR}/dunstrc ~/.config/dunst/dunstrc

# pgcli
mkdir -p ~/.config/pgcli
ln -fs ${DOTFILES_DIR}/pgcli ~/.config/pgcli/config

# htop
mkdir -p ~/.config/htop
ln -fs ${DOTFILES_DIR}/htoprc ~/.config/htop/

# cabal
mkdir -p ~/.cabal
ln -fs ${DOTFILES_DIR}/cabal.config ~/.cabal/config

# macOS
mac_symlink

# i3-wm
I3WM_DIR=~/.config/i3/
if ! [[ -f $I3WM_DIR ]]; then
	mkdir -p $I3WM_DIR
fi

ln -fs ${DOTFILES_DIR}/i3/i3.config ~/.config/i3/config
ln -fs ${DOTFILES_DIR}/i3/i3status.config ~/.config/i3/i3status.config

# Redshift
if [[ ! -e ~/.config/redshift.conf ]]; then
	mkdir -p ~/.config
	ln -sf ${DOTFILES_DIR}/redshift.conf ~/.config/redshift.conf
fi

# MIME types
MIME_FILE=$HOME/.config/mimeapps.list
if [ -e ~/.ssh/id_rsa ]; then
	rm -f $MIME_FILE
fi
ln -fs ${DOTFILES_DIR}/config/mimeapps.list $MIME_FILE

# SSH config
ln -fs ${DOTFILES_DIR}/sshconfig ~/.ssh/config

# ~/scripts directory
function setup_scripts() {
	if [ ! -d "scripts" ]; then
		git clone git@github.com:antoni/scripts.git
	fi
	ln -fs ${DOTFILES_DIR}/scripts ~/scripts

	# Screenshots
	sudo_exec ln -fs $HOME/scripts/st.sh /bin/st
}

# setup_scripts

# .ghci access
chmod g-w ~/.ghci

# set -x # echo executed commands

# /usr/bin symlinks

# Chrome
sudo_exec ln -fs /usr/bin/google-chrome-stable /usr/bin/g
# Firefox
# sudo_exec ln -fs /usr/bin/firefox /usr/bin/f
sudo_exec ln -fs $HOME/firefox/firefox /usr/bin/f
# Eclipse
sudo_exec ln -fs ~$HOME_DIR/eclipse/eclipse /usr/bin/eclipse
# clang
sudo_exec ln -fs /usr/bin/clang-$CLANG_VERSION /usr/bin/clang
sudo_exec ln -fs /usr/bin/clang++-$CLANG_VERSION /usr/bin/clang++
# clang-format
# sudo_exec ln -fs /usr/bin/clang-format-$CLANG_FORMAT_VERSION /usr/bin/clang-format
# clang-modernize
# sudo_exec ln -fs /usr/bin/clang-modernize-$CLANG_MODERNIZE_VERSION /usr/bin/clang-modernize

# adb
sudo_exec ln -fs $HOME_DIR/Android/Sdk/platform-tools/adb /usr/bin/adb

# IDEA
sudo_exec mkdir -p /etc/sysctl.d
sudo_exec ln -fs ${DOTFILES_DIR}/intellij/idea_sysctl.conf /etc/sysctl.d/idea_sysctl.conf
sudo_exec sysctl -p --system

# Global aliases
# TODO: Use linux_conditional here
# sudo_exec mkdir -p /etc/profile.d
# sudo_exec ln -fs ${DOTFILES_DIR}/global_aliases /etc/profile.d/global_aliases.sh

# lldb
sudo_exec ln -fs /usr/bin/lldb-$LLDB_VERSION /usr/bin/lldb
# IDEA
sudo_exec ln -fs $HOME_DIR/idea-I?-$IDEA_VERSION/bin/idea.sh /usr/bin/idea
# Clion
sudo_exec ln -fs $HOME_DIR/clion-$CLION_VERSION/bin/clion.sh /usr/bin/clion
# Gogland
sudo_exec ln -fs $HOME_DIR/Gogland-$GOGLAND_VERSION/bin/gogland.sh /usr/bin/gogland
# JMeter
sudo_exec ln -fs $HOME_DIR/apache-jmeter-$JMETER_VERSION/bin/jmeter /usr/bin/jmeter
# Robo 3T
sudo_exec ln -fs $HOME_DIR/robo3t-*/bin/robo3t /usr/bin/robo3t
# SweetHome3D
sudo_exec ln -fs $HOME_DIR/SweetHome3D-$SWEET_HOME_VERSION/SweetHome3D /usr/bin/sweethome
# Sublime 3
if [ -e $HOME/sublime_text_3 ]; then
	sudo_exec ln -fs $HOME/sublime_text_3/sublime_text /usr/bin/sublime
fi

if [ -e $HOME/android-studio ]; then
	sudo_exec ln -fs $HOME/android-studio/bin/studio.sh /bin/astudio
fi

case "$(uname -s)" in
Darwin)
	ln -fs ${DOTFILES_DIR}/vscode.json $HOME/Library/Application\ Support/Code/User/settings.json
	;;
Linux)
	ln -fs ${DOTFILES_DIR}/vscode.json $HOME/.config/Code/User/settings.json
	;;
CYGWIN* | MINGW32* | MSYS*) # MS Windows
	;;
esac

set +x # disable echo executed commands

# Vim

# Clone Vundle repository
VUNDLEDIR=~/.vim/bundle/Vundle.vim
if [ ! "$(ls -A ${VUNDLEDIR})" ]; then
	git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLEDIR}
fi

# CUDA snippets for Vim
# wget
# https://gist.githubusercontent.com/antoni/d8ac9973b2f28765b329/raw/811fa82e6ff738e06c11453bfa93d846d76d2386/cuda.snippets
# && mv cuda.snippets ~/.vim/bundle/vim-snippets/snippets/

echo -e "${colors[BYellow]}Things to be (possibly) done manually:\n\n\
    \t* /sys/class/backlight/\t\tto make xbacklight work"${colors[BWhite]}

# TODO: Use this
function linux_brightness_settings() {
	sudo cp brightness.sh /root/
	sudo sh -c 'echo "$USER $(hostname) = NOPASSWD: /root/brightness.sh" >> /etc/sudoers'
}

function setup_hostname() {
	hostname_default="automatown"
	echo -en "${colors[BGreen]}Enter hostname for the current machine [$hostname_default]:${colors[White]} "
	read hostname
	hostname=${hostname:-$hostname_default}
	# TODO: OS check, then uncomment
	# hostnamectl set-hostname $hostname
	mac_change_hostname $hostname

	print_success_message "Hostname changed to: $hostname"
}

setup_hostname

# Midnight Commander
ln -fs $DOTFILES_DIR/mc ~/.config

# Fedora regular updates
function fedora_regular_updates() {
	sudo dnf install dnf-automatic
	sudo systemctl enable dnf-automatic.timer && systemctl start dnf-automatic.timer
}

# Fedora upgrade
function fedora_system_upgrade() {
	sudo dnf install python3-dnf-plugin-system-upgrade
	sudo dnf system-upgrade download --refresh --releasever=26
	sudo dnf system-upgrade reboot
}

# Atom

mkdir -p $HOME/.atom

for atom in $(\ls atom); do
	rm -f $HOME/.atom/$atom
	ln -fs ~/dotfiles/atom/$atom $HOME/.atom/$atom
done

# macOS
# TextMate
ln -s /Applications/TextMate.app/Contents/MacOS/mate /usr/local/bin/mate

print_success_message "Successfully symlinked all files"
