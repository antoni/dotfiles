# Make the colors work under Terminator
# export TERM=xterm-256color

# See: https://bugs.launchpad.net/ubuntu/+source/at-spi2-core/+bug/1193236
export NO_AT_BRIDGE=1

# Get distribution name
OS=$(lsb_release -si)

# Files with commands to be loaded by both Bash and ZSH
wmname LG3D

# export GOROOT=$HOME/go 
# export PATH=$PATH:$GOROOT/bin

export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Keyboard
xbindkeys -f ~/.xbindkeysrc 

# Mouse
# TODO (FIX): Disable touchpad click (use 'xinput list' for more info)
# touchpad=$(xinput list | grep TouchPad | sed 's/.*id=\([0-9]*\).*/\1/') 
# echo $touchpad
# xinput set-prop $touchpad 279 0, 0, 0, 0, 0, 0, 0
# xinput set-prop 11 279 2, 3, 0, 0, 1, 3, 2

export QTDIR=$HOME/Qt/5.4/gcc_64/

# CUDA
export PATH=$PATH:/usr/local/cuda/bin
# Android
export PATH=$PATH:~/android-sdks/tools/:~/android-sdks/platform-tools/

export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64 

# CLion
export PATH=$PATH:/home/antoni/clion/bin

# Background image
feh --bg-scale ~/Documents/wallpaper3.jpg

# PL keyboard layout
setxkbmap pl

export EDITOR="vim"

# Fix .Xresources 
# (https://bugs.launchpad.net/ubuntu/+source/unity/+bug/1163129)
xrdb ~/.Xresources
