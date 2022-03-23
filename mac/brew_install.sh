#!/usr/bin/env bash

BREW_PACKAGES=(apache-httpd
gawk
gnu-sed
gnu-tar
coreutils
findutils
gnutls
grep
ascii
gron
mas
zoom
haskell-stack
autojump
yarn-completion
dockutil
gnumeric
gpg
testdisk
handbrake
terminal-notifier
bat
exiftool
advancecomp
hyperfine
datamash
php
mplayer
azure-cli
emscripten
deno
charles
node@16
gifski
binaryen
gifsicle
corsixth
git-gui
carthage
pipenv
starship
woff2
xhyve
act
hashcat
eth-p/software/bat-extras
qpdf
wireguard-tools
esptool
ngrok
rtmpdump
blender
yarn
fop
sourcekitten
fontforge
xz
gh
dnsmasq
dvc
docker-machine
ccat
rustup-init
tor
pass
i2p
blueutil
rtorrent
newsboat
brightness
otx
sleepwatcher
youtube-dl
cocoapods
entr
pstree
lastpass-cli
scala
libav
coreutils
rlwrap
rdiff-backup
proxychains-ng
shellcheck
hadolint
tesseract-lang
httpie
poppler
ghostscript
swi-prolog
gnu-smalltalk
# TODO: FIXME
# wine
pwgen
wget
p7zip
nginx
pandoc
tmate
qemu
lsd
ranger
jq
radare2
agda
grip
svg2png
parallel
librsvg
dark-mode
bash-completion
awscli
clang-format
tldr
wireshark
jasmin
llvm
protobuf
flex
lame
jflex
bison
transmission
R
boot2docker
nmap
tcl-tk
libpcap
nvm
calc
groovy
dos2unix
geoip
gpg
sox
git-flow
iproute2mac
lnav
hh
htop
irssi
telnet
go
python3
jq
lftp
links
lynx
jhipster
ncdu
nmap
tig
tmux
tree
# TODO: FIXME
# unrar
wget
vimpager
ack
git
duti
colordiff
cowsay
lftp
wget
axel
tree
rlwrap
tig
nmap
vim
nnn
git-crypt
speedtest_cli
aws-shell
wget
imagemagick
tree
webkit2png
graphicsmagick
python
python3
watch
watchman
automake
autoconf
htop
mackup
tmux
speedtest_cli
sbt
hub
htop
wget
ffmpeg
cmake
mysql
gradle
maven
rabbitmq
erlang
mc
vitorgalvao/tiny-scripts/cask-repair
amiaopensource/amiaos/decklinksdk
mitmproxy
ant
gradle
optipng
pngcrush
jpeg
jpegoptim
twitch
)

BREW_CASK_PACKAGES=(texshop
docker
iconjar
growlnotify
electrum
http-toolkit
streamlabs-obs
cloudflare-warp
anaconda
opera-gx
powershell
caffeine
dashlane
openvpn-connect
google-cloud-sdk
expressvpn
bitwarden
wickrme
messenger
tableplus
qlvideo
zulip
recordit
fugu
workplace-chat
rstudio
angry-ip-scanner
turbo-boost-switcher
paragon-ntfs
gog-galaxy
freecad
intel-haxm
hammerspoon
cyberduck
mountain-duck
transmit
keyboard-maestro
moom
proxyman
raycast
jubler
postman
obsidian
bettertouchtool
asana
elmedia-player
atom
daisydisk
binance
omnidisksweeper
miro
image2icon
abstract
figma
clion
qcad
altair-graphql-client
bitwarden
adobe-creative-cloud
# idafree
zeplin
beaker-browser
stretchly
emacs
dogecoin
sketchup
league-of-legends
colour-contrast-analyser
# does not run on macOS > Big Sur
# filebot
namebench
# crossover
little-snitch
imazing
discord
github
aquamacs
WebPQuickLook
robo-3t
studio-3t
brave-browser
grammarly
obs
alfred
qlstephen
starcraft
karabiner-elements
steam
spotify
macsvg
mpv
whatsapp
skype-for-business
telegram
epic-games
imageoptim
balenaetcher
squeak
inkscape
thunderbird
snagit
dropbox
epic
tex-live-utility
eclipse-jee
android-file-transfer
viber
gimp
hopper-debugger-server
atext
visual-studio
visual-studio-code
visual-studio-code-insiders
koa11y
mysides
ngrok
xmind-zen
jetbrains-toolbox
atom
private-eye
fontforge
opera-developer
pharo-project/pharo/pharo-launcher
macpass
transmission
transmission-remote-gui
kitematic 
gpg-suite
# Does not work on Monterey
# pref-setter
db-browser-for-sqlite
signal
soda-player
tunnelblick
rowanj-gitx
xquartz
skitch
mounty
wireshark-chmodbpf
dropbox
pym-player
transmission
nordvpn
sequel-pro
tor-browser
safari-technology-preview
mactex
owasp-zap
evernote
the-unarchiver
firefox
# google-chrome
jwbargsten/misc/defbro
google-chrome-canary
google-drive-file-stream
macdown
postman
keybase
spotifree
macs-fan-control
vlc
# vlc-webplugin
cleanmymac
flux
iterm2-nightly
robo-3t
gimp
kindle
google-earth-pro
omnigraffle
skype
slack
wkhtmltopdf
spectacle
mysqlworkbench
sublime-text
the-unarchiver
# TODO: Move to some other function
# virtualbox
robo-3t
hyper
gitkraken
homebrew/cask-versions/firefox-developer-edition
opera
webstorm
libreoffice
quip
karabiner-elements
spectacle
android-studio
android-sdk
)

function sdk_man_install() {
    # SDKman
    curl -s "https://get.sdkman.io" | bash

    sdk install gradle
    sdk install groovy
    sdk install scala
    sdk install grails
    sdk install springboot
    sdk install maven
    sdk install sbt
}

function scala_post_install() {
    echo '-J-XX:+CMSClassUnloadingEnabled' >> /usr/local/etc/sbtopts
    echo '-J-Xmx2G' >> /usr/local/etc/sbtopts
}

function vim_you_complete_me_install() {
    cd ~/.vim/bundle/YouCompleteMe || exit 1
    ./install.py --clang-completer
}

function install_cargo() {
    brew install rust;
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null ; brew install caskroom/cask/brew-cask 2> /dev/null;
    brew install --cask cargo;
}

function install_docker() {
    # https://apple.stackexchange.com/questions/373888/how-do-i-start-the-docker-daemon-on-macos/373914#373914
    brew install --cask docker virtualbox
    brew install docker-machine
    docker-machine create --driver virtualbox default
    docker-machine restart
    eval "$(docker-machine env default)" # This might throw an TSI connection error. In that case run docker-machine regenerate-certs default
    docker-machine restart # maybe needed
    docker run hello-world
}

function install_dmidecode() {
    brew install cavaliercoder/dmidecode/dmidecode
}

function mac_install_misc() {
    # Bash
    brew install bash
    brew link bash
    chsh -s /usr/local/bin/bash

    brew install bash-completion
    brew tap homebrew/homebrew-core

    # Brew service (launchd)
    brew tap homebrew/services

    # Packages needed to install other packages later
    brew install svn node@16

    brew install --cask \
    # Fonts
    brew tap homebrew/cask-fonts
    brew install --cask \
        font-fira-code \
        font-fira-mono \
        font-fira-mono-for-powerline \
        font-inconsolata \
        font-fira-sans

    # TODO: Make it work again
    # vim_you_complete_me_install

    # brew install jmeter --with-plugins
    brew install jmeter

    # Install Quick Look plugins https://github.com/sindresorhus/quick-look-plugins
    brew install --cask qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv webpquicklook qlvideo

    # Fonts
    brew install --cask font-menlo-for-powerline font-inconsolata font-source-code-pro font-hasklig font-monoid

    # Heroku CLI
    brew install --cask dotnet-sdk
    brew tap heroku/brew && brew install heroku

    # mongoDB
    brew tap mongodb/brew
    brew install mongodb-community@5.0

    # Dart langauge
    brew tap dart-lang/dart
    brew install dart

    # sdk_man_install
}

function install_packages_with_security_approvals() {
brew install --cask virtualbox 
}
