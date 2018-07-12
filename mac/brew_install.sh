BREW_PACKAGES=(mongodb
dockutil
gpg
pwgen
nginx
jq
bash-completion
awscli
R
bash-completion
calc
groovy
ccrypt
dos2unix
geoip
ffmpeg
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
)

BREW_CASK_PACKAGES=(texshop
caffeine
rstudio
mounty
dropbox
sequel-pro
torbrowser
bettertouchtool
evernote
the-unarchiver
firefox
google-chrome
google-chrome-canary
google-drive-file-stream
macdown
postman
flux
iterm2
gimp
kindle
omnigraffle
skype
slack
wkhtmltopdf
spectacle
spotify
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
