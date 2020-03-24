BREW_PACKAGES=(mongodb
ascii
mas
dockutil
gpg
bat
node
wireguard-tools
rtmpdump
yarn
sourcekitten
fontforge
xz
dvc
ccat
pass
blueutil
newsboat
brightness
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
proxychains
shellcheck
tesseract-lang
osquery
httpie
poppler
gnu-sed
ghostscript
swi-prolog
gnu-smalltalk
wine
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
unrar
wget
vimpager
mongodb
ack
git
duti
colordiff
coreutils
gawk
gnu-sed
cowsay
lftp
wget
axel
tree
unrar
rlwrap
tig
nmap
vim
nnn
emacs
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
optipng
jpeg
jpegoptim
vitorgalvao/tiny-scripts/cask-repair
amiaopensource/amiaos/decklinksdk
mitmproxy
ant
gradle
)

BREW_CASK_PACKAGES=(texshop
caffeine
bitwarden
rstudio
elmedia-player
clion
bitwarden
java
imazing
grammarly
alfred
spotify
macsvg
mpv
whatsapp
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
atext
visual-studio-code
koa11y
mysides
ngrok
xmind-zen
jetbrains-toolbox
atom
private-eye
fontforge
opera-developer
macpass
transmission-remote-gui
kitematic 
gpg-suite
pref-setter
db-browser-for-sqlite
zoom
haskell-stack
signal
soda-player
tunnelblick
rowanj-gitx
blue-jeans
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
google-chrome-canary
google-drive-file-stream
macdown
postman
keybase
spotifree
macs-fan-control
vlc
vlc-webplugin
cleanmymac
flux
iterm2-nightly
veracrypt
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
virtualbox
macvim
robo-3t
hyper
gitkraken
caskroom/versions/firefox-developer-edition
opera
webstorm
libreoffice
quip
karabiner-elements
spectacle
intel-haxm
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

function mac_install_misc() {
    # Bash
    brew install bash
    brew link bash
    chsh -s /usr/local/bin/bash

    brew install bash-completion
    brew tap homebrew/homebrew-core

    # Brew service (launchd)
    brew tap homebrew/services

    # Fonts
    brew tap homebrew/cask-fonts
    brew cask install \
        font-fira-code \
        font-fira-mono \
        font-fira-mono-for-powerline \
        font-fira-sans

    sdk_man_install
    vim_you_complete_me_install

    # brew install jmeter --with-plugins
    brew install jmeter

    # Install Quick Look plugins https://github.com/sindresorhus/quick-look-plugins
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv webpquicklook qlvideo

    # Fonts
    brew cask install font-menlo-for-powerline font-inconsolata font-source-code-pro font-hasklig font-monoid

    # Dart langauge
    brew tap dart-lang/dart
    brew install dart
}

function install_cargo() {
    brew install rust;
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null ; brew install caskroom/cask/brew-cask 2> /dev/null;
    brew cask install cargo;
}

function install_docker() {
    # Get Docker for Mac from here first: https://www.docker.com/docker-mac
    brew cask install docker-toolbox;
}

function install_dmidecode() {
    brew install cavaliercoder/dmidecode/dmidecode
}

function install_fuse() {
    # https://medium.com/@technikhil/setting-up-ntfs-3g-on-your-mac-os-sierra-11eff1749898
    brew cask install osxfuse
    brew install ntfs-3g
}
