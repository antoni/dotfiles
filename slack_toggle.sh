#!/usr/bin/bash

# Toggles Slack (on/off)
if ! `killall slack`; then
    notify-send --urgency=low --expire-time=1000 "Starting slack..." 
    slack;
fi
