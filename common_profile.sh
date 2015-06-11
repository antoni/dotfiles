# Make the colors work under Terminator
# export TERM=xterm-256color

# See: https://bugs.launchpad.net/ubuntu/+source/at-spi2-core/+bug/1193236
export NO_AT_BRIDGE=1

# Get distribution name
OS=$(lsb_release -si)

# Files with commands to be loaded by both Bash and ZSH
wmname LG3D

# Keyboard
# if command_exists xbindkeys; then
    # xbindkeys -f ~/.xbindkeysrc 
# fi

# Mouse
# TODO (FIX): Disable touchpad click (use 'xinput list' for more info)
# touchpad=$(xinput list | grep TouchPad | sed 's/.*id=\([0-9]*\).*/\1/') 
# echo $touchpad
# xinput set-prop $touchpad 279 0, 0, 0, 0, 0, 0, 0
# xinput set-prop 11 279 2, 3, 0, 0, 1, 3, 2

export QTDIR=$HOME/Qt/5.4/gcc_64/

# Background image
WALLPAPER=~/Documents/wallpaper3.jpg
if [ -e WALLPAPER ]; then
    feh --bg-scale WALLPAPER
fi

# PL keyboard layout
# if command_exists setxkbmap; then
    # setxkbmap pl
# fi

export EDITOR="vim"

# Fix .Xresources 
# (https://bugs.launchpad.net/ubuntu/+source/unity/+bug/1163129)
if [ -e ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

source ~/.paths
# Disable touchpad while typing (reactive 1 second after typing finished) 
if command_exists xinput && ((xinput list | grep synaptics > /dev/null) || (xinput list | grep ALPS > /dev/null)); then
    # echo "syndaemon configured"
    syndaemon -i 1 -d 
fi

# Make the Windows key a useable mod key:
# xmodmap -e "remove mod4 = F13"
# xmodmap -e "keycode 115 = Super_L"
# xmodmap -e "add mod4 = Super_L"

# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
