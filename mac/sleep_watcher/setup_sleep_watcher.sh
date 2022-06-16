#!/usr/bin/env bash

ln -sfv ~/dotfiles/mac/sleep_watcher/de.bernhard-baehr.sleepwatcher-20compatibility-localuser.plist ~/Library/LaunchAgents/

# Unload in case it has been loaded with incorrect configuration before
launchctl unload ~/Library/LaunchAgents/de.bernhard-baehr.sleepwatcher-20compatibility-localuser.plist &>/dev/null
launchctl load ~/Library/LaunchAgents/de.bernhard-baehr.sleepwatcher-20compatibility-localuser.plist
