#!/usr/bin/env bash

# See: https://github.com/Homebrew/homebrew-core/commit/f75cb092032c2eb921ba0bcdcf6a45af5cf86714#diff-8f4deb87ce96b9c5efe97be3288bb406
FFMPEG_TAP_NAME=homebrew-ffmpeg/ffmpeg
brew tap $FFMPEG_TAP_NAME
brew install $FFMPEG_TAP_NAME/ffmpeg "$(brew options $FFMPEG_TAP_NAME/ffmpeg | \grep -vE '\s' | \grep -- '--with-' | grep -v 'chromaprint' | tr '\n' ' ')"

brew install chromaprint
