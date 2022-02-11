#!/usr/bin/env bash

_user=`who | grep console | awk '{ print $1 }'`

sudo -u $_user defaults write /Users/$_user/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true
