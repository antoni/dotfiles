#!/usr/bin/env bash
# ⌘
function command_exists () { type "$1" &> /dev/null ; }

# Returns internal application ID for given application name
function app_id {
    osascript -e "id of app \"$1\""
}

# Updates wallpapers on all screens
# Usage:
# set_wallpaper ~/Documents/wallpaper_evo_x_1.jpg
function set_wallpaper() {
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$1\""
}

# Disabling the dialogs shown when opening an application for the first time
# $1 - application .app bundle location
# e.g.: disable_first_open_dialog /Applications/PYM\ Player.app
function disable_first_open_dialog() {
    xattr -rd com.apple.quarantine "$1"
}

function symlink_vlc_rc() {
    rm -f /Users/`whoami`/Library/Preferences/org.videolan.vlc/vlcrc
    ln -sf ~/dotfiles/vlcrc /Users/`whoami`/Library/Preferences/org.videolan.vlc/vlcrc
}

# Installs hping with TCL scripting support
function install_hping() {
    mkdir -p ~/hping
    # cd hping
    git clone https://github.com/antirez/hping.git ~/hping
    # brew install tcl-tk
    # brew install libpcap
    pushd ~/hping
    ./configure
    make
    sudo make install
    # hping
    sudo cp -f hping3 /usr/local/sbin/
    sudo cp -f hping3 /usr/local/sbin/hping
    popd
}

function post_install() {
    # Ask for the administrator password upfront
    sudo -v

    # Make 'airport' command available
    sudo ln -fs /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport

    # Change default application for given file type
    if command_exists duti; then
        duti -s `app_id "PYM Player"`    .avi  all;
        duti -s `app_id "PYM Player"`    .mkv  all;
        duti -s `app_id "PYM Player"`    .mp4  all;
        duti -s `app_id "TextMate"`      .txt  all;
        duti -s `app_id "TeXShop"`       .tex  all;
        duti -s `app_id "MacDown"`       .md   all;
        duti -s `app_id "Google Chrome"` .webm all;
        duti -s `app_id "LibreOffice"`   .xls  all;
        duti -s `app_id "LibreOffice"`   .xlsx all;
        # Won't work (for any application), see ~/scripts/default_browser_chrome.sh
        # duti -s `app_id "*"`      .html all;
    else
        printf "You have to install 'duti' first"
    fi

    disable_first_open_dialog "/Applications/PYM Player.app"

    # Create link for 'jsc'
    ln -fs /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin

    # Create link for 'package.json' to avoid some errors and warnings
    # when updating globally installed NPM packages
    ln -fs ~/dotfiles/package.json ~/package.json

    # install_hping
    symlink_vlc_rc

    set_wallpaper ~/Documents/wallpaper_evo_x_1.jpg

    echo Succesfully performed all post-install tasks
}

# Symlink TextMate
# sudo ln -fs /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate

# Clear the Dock
# dockutil --remove all

post_install