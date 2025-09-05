#!/usr/bin/env bash

# Source: https://gist.github.com/Piasy/b5dfd5c048eb69d1b91719988c0325d8#gistcomment-3314991

# TODO: Replace with this?: https://github.com/markus-perl/ffmpeg-build-script?tab=readme-ov-file#common-install-and-build-macos-linux

# # start clean. make sure you have xcode installed and all the other basics such as brew.
# brew uninstall --force ffmpeg chromaprint amiaopensource/amiaos/decklinksdk

# # installs ffmpeg vanilla as dependency
# brew install amiaopensource/amiaos/decklinksdk

# # let's neuter that shit
# brew unlink ffmpeg

# # install dependencies to cook our own
# brew install automake fdk-aac git lame libass libtool libvorbis libvpx opus \
# 	sdl shtool texi2html theora wget x264 x265 xvid nasm
# # and we're done brewing. Lay off the beer for now.

# # clone head
# # if you ever want to update or customize FFmpeg at any point
# # just delete the binary (/usr/local/bin/ffmpeg in this case)
# # and start again from this step.
# git clone https://git.ffmpeg.org/ffmpeg.git $HOME/tmp/ffmpeg
# cd $HOME/tmp/ffmpeg || exit

# # at this point, ChromaPrint has to be installed, else this step will fail.
# # sample compilation command. Customize this to your needs
# # the flags are different from the brew version LDO. RTFM.
# ./configure --prefix=/usr/local --enable-gpl --enable-nonfree \
# 	--enable-libmp3lame \
# 	--enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 \
# 	--enable-libopus --enable-libxvid --enable-chromaprint --samples=fate-suite/
# # TODO: Add --enable-decklink --enable-libass --enable-libfdk-aac --enable-libfreetype

# # the actual install once you're done configuring
# make && make install

# ffmpeg should install to /usr/local/bin/ffmpeg. Test this out
command -v ffmpeg
ffmpeg -version
