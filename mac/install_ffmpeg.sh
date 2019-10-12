#!/usr/bin/env bash

FFMPEG_TAP_NAME=homebrew-ffmpeg/ffmpeg
brew tap $FFMPEG_TAP_NAME
brew install $FFMPEG_TAP_NAME/ffmpeg $(brew options $FFMPEG_TAP_NAME/ffmpeg | grep -vE '\s' | grep -- '--with-' | tr '\n' ' ')
