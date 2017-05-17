# Common profile file for bash and zsh

# Overcome the madness: http://www.economyofeffort.com/2014/07/04/zsh/
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# See: https://bugs.launchpad.net/ubuntu/+source/at-spi2-core/+bug/1193236
export NO_AT_BRIDGE=1

# Get distribution name
OS="CentOS"
if command_exists lsb_release; then
    OS=$(lsb_release -si)
fi

# Files with commands to be loaded by both Bash and ZSH
if command_exists wmname; then
    wmname LG3D
fi

# Keyboard
if command_exists xbindkeys; then
    xbindkeys -f ~/.xbindkeysrc 
fi

# Qt
export QTDIR=$HOME/Qt/5.4/gcc_64/

# Background image
WALLPAPER=~/Documents/wallpaper5.jpg
if [ -e $WALLPAPER ]; then
    feh --bg-scale $WALLPAPER
fi

# Executed when in X mode (e.g. DISPLAY is set)
if [ -z ${DISPLAY} ]; then  
    # DISPLAY unset
else
    xrandr --output VGA1 --mode 1680x1050 --right-of LVDS1

    # PL keyboard layout
    if command_exists setxkbmap && [[ "$unamestr" != 'Darwin' ]] ; then
        setxkbmap pl
    fi
fi # end DISPLAY setup

export EDITOR="vim"

# Fix .Xresources 
# (https://bugs.launchpad.net/ubuntu/+source/unity/+bug/1163129)
if [ -e ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# Disable touchpad while typing (reactive 1 second after typing finished) 
# if command_exists xinput && ((xinput list | grep synaptics > /dev/null) || (xinput list | grep ALPS > /dev/null)); then
# echo "syndaemon configured"
# syndaemon -i 1 -d 
# fi

# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

if [ -f ~/.optional.sh ]; then
    source ~/.optional.sh
fi

# Disable iBUS (IntelliJ, etc.)
# export IBUS_ENABLE_SYNC_MODE=1

# Go
# export GOROOT=$HOME/go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go/
export PATH=$PATH:/usr/local/go/bin
# export PATH=$PATH:$GOROOT/bin

# CUDA
export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/lib

# MPI
export PATH=$PATH:/usr/lib64/openmpi/bin
