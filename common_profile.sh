#!/usr/bin/env bash

# Aliases and custom functions
source "$HOME"/dotfiles/aliases

export MANPAGER="less --ignore-case"

# Wallpaper
WALLPAPER=~/Documents/wallpaper8.jpg

# Locale (24-hour time, UK formats)
export LANG=en_GB.UTF-8
# LC_ALL intentionally unset

export EDITOR="vim"
# Overcome the madness: http://www.economyofeffort.com/2014/07/04/zsh/
export TERM=xterm-256color

[ -n "$TMUX" ] && export TERM=screen-256color

# Fixes different things on Ubuntu. May not be up-to-date, since Ubuntu gets
# better every year
function fix_ubuntu() {
	# See: https://bugs.launchpad.net/ubuntu/+source/at-spi2-core/+bug/1193236
	export NO_AT_BRIDGE=1
	# Fix .Xresources
	# (https://bugs.launchpad.net/ubuntu/+source/unity/+bug/1163129)
	if [ -e ~/.Xresources ]; then
		xrdb ~/.Xresources
	fi

	# Files with commands to be loaded by both Bash and ZSH
	if command_exists wmname; then
		wmname LG3D
	fi
	# Disable touchpad while typing (reactive 1 second after typing finished)
	# if command_exists xinput && ((xinput list | grep synaptics > /dev/null) || (xinput list | grep ALPS > /dev/null)); then
	# echo "syndaemon configured"
	# syndaemon -i 1 -d
	# fi
}

# Get distribution name
# OS="CentOS"
# if command_exists lsb_release; then
# OS=$(lsb_release -si)
# fi

# Executed when in X mode (e.g. DISPLAY is set)
# xrandr_display_count=`xrandr --query | grep " connected" | wc -l`
# if [ -z ${DISPLAY} ] || [ $xrandr_display_count -eq 1 ] ; then
# DISPLAY unset
# :
# else
# xrandr --output VGA1 --mode 1680x1050 --right-of LVDS1

# PL keyboard layout
# if command_exists setxkbmap && [[ "$UNAME_OUTPUT" != 'Darwin' ]] ; then
# setxkbmap pl
# fi
# fi # end DISPLAY setup

# if [ -f ~/.optional.sh ]; then
# 	source "$HOME"/.optional.sh
# fi

function execute_on_login_only() {
	# Wallpaper
	if [ -e $WALLPAPER ]; then
		feh --bg-scale $WALLPAPER
	fi
}

# This takes too much time
# execute_on_login_only

# Keyboard
if command_exists xbindkeys && [[ -z $IS_WSL ]]; then
	killall xbindkeys 2>/dev/null
	xbindkeys -f ~/.xbindkeysrc
fi

export HOMEBREW_AUTO_UPDATE_SECS="$((60 * 60 * 3))"

# macOS only (delete symlink created after system update)
rm -f ~/Desktop/Relocated\ Items

# Make Bash 4 work on macOS
export PATH="/usr/local/bin:$PATH"

export PATH=$PATH:$HOME/.npm-packages/bin:/mnt/c/Windows:/mnt/c/Windows/System32/WindowsPowerShell/v1.0:/mnt/c/Windows/System32

# Windows (WSL)
if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
	# Making GUI applications work on WSL:
	# https://github.com/gencay/vscode-chatgpt/issues/25#issuecomment-1425089512
	export DISPLAY=:0
	# alternatively try:
	# export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0
	# or:
	# export DISPLAY=$(ip route list default | awk '{print $3}'):0

	export LIBGL_ALWAYS_INDIRECT=1
fi

export ANDROID_HOME=/home/antoni/Android/cmdline-tools/latest
export ANDROID_SDK_ROOT=/home/antoni/Android

PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
PATH=$PATH:$ANDROID_HOME/bin

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

if [ -e "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi
