BREW_PACKAGES=(mongodb
mas
dockutil
gpg
pass
coreutils
rlwrap
osquery
httpie
gnu-sed
pwgen
p7zip
nginx
qemu
ranger
jq
radare2
grip
svg2png
parallel
librsvg
dark-mode
bash-completion
awscli
clang-format
wireshark
jasmin
llvm
protobuf
flex
lame
jflex
bison
transmission
transmission-remote-gui
R
boot2docker
bash-completion
nmap
tcl-tk
libpcap
nvm
calc
groovy
ccrypt
dos2unix
geoip
gpg
ffmpeg
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
bash-completion
bash completion script
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
xquartz
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
mitmproxy
)

BREW_CASK_PACKAGES=(texshop
caffeine
rstudio
elmedia-player
clion
alfred
whatsapp
visual-studio-code
jetbrains-toolbox
leksah
atom
opera-developer
macpass
kitematic 
pref-setter
db-browser-for-sqlite
signal
soda-player
tunnelblick
rowanj-gitx
blue-jeans
skitch
mounty
wireshark
wireshark-chmodbpf
dropbox
pym-player
transmission
nordvpn
sequel-pro
torbrowser
bettertouchtool
safari-technology-preview
owasp-zap
evernote
the-unarchiver
firefox
google-chrome
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
sublime
the-unarchiver
virtualbox
macvim
robo-3t
hyper
gitkraken
caskroom/versions/firefoxdeveloperedition
opera
webstorm
libreoffice
quip
karabiner-elements
spectacle)

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
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
}

function mac_install_misc() {
    # Bash
    brew install bash
    brew link bash
    chsh -s /usr/local/bin/bash

    brew install bash-completion
    brew tap homebrew/completions

    # Java 8
    brew tap caskroom/versions
    brew cask install java8

    # Brew service (launchd)
    brew tap homebrew/services

    # Fonts
    brew tap caskroom/fonts
    brew cask install \
        font-fira-code \
        font-fira-mono \
        font-fira-mono-for-powerline \
        font-fira-sans

    sdk_man_install
    vim_you_complete_me_install

    brew install jmeter --with-plugins

    # Install Quick Look plugins https://github.com/sindresorhus/quick-look-plugins
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv webpquicklook qlvideo

    # Fonts
    brew cask install font-menlo-for-powerline font-inconsolata font-source-code-pro font-hasklig font-monoid font-pragmata-pro
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