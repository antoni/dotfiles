# Common profile file for Bash and ZSH

# Wallpaper
WALLPAPER=~/Documents/wallpaper8.jpg

export EDITOR="vim"
# Overcome the madness: http://www.economyofeffort.com/2014/07/04/zsh/
export TERM=xterm-256color

[ -n "$TMUX" ] && export TERM=screen-256color

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


# Qt
# export QTDIR=$HOME/Qt/5.4/gcc_64/

# Executed when in X mode (e.g. DISPLAY is set)
# xrandr_display_count=`xrandr --query | grep " connected" | wc -l`
# if [ -z ${DISPLAY} ] || [ $xrandr_display_count -eq 1 ] ; then
# DISPLAY unset
# :
# else
# xrandr --output VGA1 --mode 1680x1050 --right-of LVDS1

# PL keyboard layout
# if command_exists setxkbmap && [[ "$unamestr" != 'Darwin' ]] ; then
# setxkbmap pl
# fi
# fi # end DISPLAY setup

if [ -f ~/.optional.sh ]; then
    source ~/.optional.sh
fi

# Disable iBUS (IntelliJ, etc.)
# export IBUS_ENABLE_SYNC_MODE=1

# Go
export GOROOT=$HOME/gosrc
# export GOROOT=/usr/local/go
export GOPATH=$HOME/go
# export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOROOT/bin

# CUDA
export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/lib

# MPI
export PATH=$PATH:/usr/lib64/openmpi/bin

# Rust
source $HOME/.cargo/env

function execute_on_login_only() {
    # Wallpaper
    if [ -e $WALLPAPER ]; then
        feh --bg-scale $WALLPAPER
    fi

    # Keyboard
    if command_exists xbindkeys; then
        killall xbindkeys 2> /dev/null
        xbindkeys -f ~/.xbindkeysrc 
    fi
}
