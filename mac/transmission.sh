#!/usr/bin/env bash

# Settings file location
# ls -ld ~/Library/Preferences/org.m0k.transmission.*

defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false
defaults write org.m0k.transmission CheckRemoveDownloading -bool true
defaults write org.m0k.transmission DownloadChoice -string 'Constant'
defaults write org.m0k.transmission DownloadFolder -string "$HOME/Documents"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Documents"
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false
defaults write org.m0k.transmission RandomPort -bool true
defaults write org.m0k.transmission RandomPort -bool false
