#!/usr/bin/env bash

# Returns internal application ID for given application name
function app_id { osascript -e "id of app \"$1\"" }

# Change default application for given file type

# TODO: Check if duti is available

duti -s `app_id "PYM Player"` .mp4 all
duti -s `app_id "Google Chrome"` .html all
duti -s `app_id "TextMate"` .txt all

# Symlink TextMate
sudo ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate

# Clear the Dock
dockutil --remove all


