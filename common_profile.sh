# Common profile file for Bash and ZSH
source ~/.aliases

export MANPAGER="less --ignore-case"

# Wallpaper
WALLPAPER=~/Documents/wallpaper8.jpg

# Needed by f.e. Python 3
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
# export GOROOT=$HOME/gosrc
# export GOPATH=$HOME/go
# export PATH=$PATH:$GOROOT/bin

# Qt
# export QTDIR=$HOME/Qt/5.4/gcc_64/

# CUDA
# export PATH=$PATH:/usr/local/cuda/bin
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/lib

# MPI
# export PATH=$PATH:/usr/lib64/openmpi/bin

# Rust
# source $HOME/.cargo/env

function execute_on_login_only() {
    # Wallpaper
    if [ -e $WALLPAPER ]; then
    feh --bg-scale $WALLPAPER
    fi
}

# This takes too much time
# execute_on_login_only

# Keyboard
if command_exists xbindkeys; then
    killall xbindkeys 2> /dev/null
    xbindkeys -f ~/.xbindkeysrc 
fi

# TODO: Add macOS conditional
# Uncomment for no Homebrew updates at all
# export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_AUTO_UPDATE_SECS="$((60*60*3))"

# Android development
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

# SDK Man replaced GVM. Using for Groovy, Gradle, and Maven Version Management
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#
# # NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export ARTIFACTORY_NPM_TOKEN="eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJ6eG1hak9sUGVvS1E2RVpZUnI0MHJGX2puczhxTVlrbkNwTlFnMldxMUJzIn0.eyJzdWIiOiJqZnJ0QDAxZG0wNGN2c2c3ejMxMTdnNHpwN3kwamN6XC91c2Vyc1wvb3B0aW11cy1kZXYiLCJzY3AiOiJtZW1iZXItb2YtZ3JvdXBzOiogYXBpOioiLCJhdWQiOiJqZnJ0QDAxZG0wNGN2c2c3ejMxMTdnNHpwN3kwamN6IiwiaXNzIjoiamZydEAwMWRtMDRjdnNnN3ozMTE3ZzR6cDd5MGpjelwvdXNlcnNcL29wdGltdXMtZGV2IiwiaWF0IjoxNTY4NjI1NDA4LCJqdGkiOiJmMzIwYzJkMC1kOGY2LTRiZmUtYTI0ZC0xMjhjM2RlMTNmYTkifQ.HDfThYDJDuQpA-tDk6iDlpAClhIHM8pDA5AJkp9ImO3BaOrc76lvy_Mg2gXiM1OX3JzZCzM__nMSDfovwhGZjXqTD-q6LUi1rhtRbJYaSkXpAPt7edHneoneFCg4E-FlxQhs0Im61W6vbe_NvAZqLclteWKsBytfiouG9_9sVM9ewTf4XP0Y0o2eumaIcnchBxVAJp52j4xXvhNkQ_tHCZ-zFaJgb-SRHR9nClwDPsL7l5KEYclLzHGbpf1MDSr8ZBoEBXqNDlb_C3-O485vvpPibGpqdJ_hA4u1Jty9tqerK_R3MNmvxzyZbcbdgmoYt8VoUM7jVJ7FI568Z-0uow"
