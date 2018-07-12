#!/usr/bin/env bash

function command_exists () { type "$1" &> /dev/null ; }

# Returns internal application ID for given application name
function app_id {
    osascript -e "id of app \"$1\""
}

# Change default application for given file type
if command_exists duti; then
    duti -s `app_id "PYM Player"` .avi all;
    duti -s `app_id "PYM Player"` .mkv all;
    duti -s `app_id "PYM Player"` .mp4 all;
    duti -s `app_id "TextMate"`   .html all;
    duti -s `app_id "TextMate"`   .txt all;
else
    printf "You have to install 'duti' first"
fi

# Symlink TextMate
sudo ln -fs /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate

# Clear the Dock
dockutil --remove all


