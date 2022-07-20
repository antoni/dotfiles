#!/usr/bin/env bash

BREW_PACKAGES_MUST_HAVE=(
	gawk
	gnu-sed
	gnu-tar
	coreutils
	findutils
	gnutls
	grep
	ascii
	gpg
	exiftool
	shfmt
	node@16
	ngrok
	yarn
	zoom
	azure-cli
	gh
	pstree
	coreutils
	shellcheck
	fpp
	wget
	pandoc
	jq
	parallel
	clang-format
	llvm
	nmap
	gpg
	htop
	go
	python3
	tmux
	tree
	git
	duti
	vim
	imagemagick
	watch
	ffmpeg
	cmake
	mc
)

BREW_PACKAGES_MAY_HAVE=(apache-httpd
	gron
	mas
	haskell-stack
	autojump
	yarn-completion
	dockutil
	gnumeric
	testdisk
	handbrake
	terminal-notifier
	bat
	advancecomp
	hyperfine
	datamash
	php
	mplayer
	pillow
	emscripten
	deno
	charles
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
	rtmpdump
	blender
	fop
	sourcekitten
	fontforge
	xz
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
	yt-dlp/taps/yt-dlp
	youtube-dl
	cocoapods
	entr
	ansible
	lastpass-cli
	scala
	libav
	rlwrap
	rdiff-backup
	proxychains-ng
	hadolint
	tesseract-lang
	httpie
	poppler
	ghostscript
	swi-prolog
	gnu-smalltalk
	pwgen
	p7zip
	nginx
	tmate
	qemu
	lsd
	ranger
	radare2
	agda
	grip
	svg2png
	librsvg
	dark-mode
	bash-completion
	awscli
	tldr
	wireshark
	jasmin
	protobuf
	flex
	lame
	jflex
	bison
	transmission
	R
	boot2docker
	tcl-tk
	libpcap
	nvm
	calc
	groovy
	dos2unix
	geoip
	sox
	git-flow
	iproute2mac
	lnav
	hh
	irssi
	telnet
	lftp
	links
	lynx
	jhipster
	ncdu
	tig
	vimpager
	ack
	colordiff
	cowsay
	lftp
	axel
	tree
	rlwrap
	tig
	nmap
	nnn
	git-crypt
	speedtest_cli
	aws-shell
	webkit2png
	graphicsmagick
	watchman
	automake
	autoconf
	mackup
	speedtest_cli
	sbt
	hub
	mysql
	gradle
	maven
	rabbitmq
	erlang
	vitorgalvao/tiny-scripts/cask-repair
	amiaopensource/amiaos/decklinksdk
	carlocab/personal/unrar
	mitmproxy
	ant
	optipng
	pngcrush
	jpeg
	jpegoptim
	terraform
	terragrunt
	tflint
)

BREW_CASK_PACKAGES_MUST_HAVE=(
    google-chrome
	iterm2-nightly
	atom
	spotify
	alfred
	mpv
	whatsapp
	telegram
	atext
	visual-studio-code
	visual-studio-code-insiders
	signal
	pym-player
	mactex
	firefox
	vlc
	slack
	libreoffice
	espanso
)

BREW_CASK_PACKAGES_MAY_HAVE=(texshop
	wine-stable
	anydesk
	microsoft-remote-desktop
	docker
	docker-compose
	terraform
	iconjar
	growlnotify
	electrum
	http-toolkit
	streamlabs-obs
	cloudflare-warp
	brave-browser
	anaconda
	opera-gx
    disk-drill
	powershell
	caffeine
	dashlane
	lens
	openvpn-connect
	google-cloud-sdk
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
	librecad
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
	daisydisk
	binance
	omnidisksweeper
	image2icon
	miro
	abstract
	figma
	zeplin
	clion
	qcad
	altair-graphql-client
	bitwarden
	adobe-creative-cloud
	idafree
	beaker-browser
	stretchly
	emacs
	dogecoin
	sketchup
	league-of-legends
	colour-contrast-analyser
	namebench
	little-snitch
	imazing
	discord
	github
	aquamacs
	WebPQuickLook
	robo-3t
	studio-3t
	grammarly
	obs
	qlstephen
	starcraft
	karabiner-elements
	steam
	macsvg
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
	visual-studio
	koa11y
	mysides
	xmind-zen
	jetbrains-toolbox
	private-eye
	fontforge
	opera-developer
	macpass
	transmission
	transmission-remote-gui
	kitematic
	gpg-suite
	db-browser-for-sqlite
	soda-player
	tunnelblick
	rowanj-gitx
	xquartz
	skitch
	mounty
	wireshark-chmodbpf
	transmission
	nordvpn
	sequel-pro
	tor-browser
	safari-technology-preview
	owasp-zap
	evernote
	the-unarchiver
	google-chrome-canary
	google-drive-file-stream
	macdown
	postman
	keybase
	spotifree
	macs-fan-control
	jwbargsten/misc/defbro
	cleanmymac
	flux
	robo-3t
	gimp
	kindle
	google-earth-pro
	omnigraffle
	skype
	wkhtmltopdf
	spectacle
	mysqlworkbench
	sublime-text
	the-unarchiver
	robo-3t
	hyper
	gitkraken
	opera
	webstorm
	quip
	karabiner-elements
	spectacle
	android-studio
	android-sdk
	homebrew/cask-versions/firefox-developer-edition
	pharo-project/pharo/pharo-launcher
	vagrant
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
	echo '-J-XX:+CMSClassUnloadingEnabled' >>/usr/local/etc/sbtopts
	echo '-J-Xmx2G' >>/usr/local/etc/sbtopts
}

function vim_you_complete_me_install() {
	cd ~/.vim/bundle/YouCompleteMe || exit 1
	./install.py --clang-completer
}

function install_cargo() {
	brew install rust
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null 2>/dev/null
	brew install caskroom/cask/brew-cask 2>/dev/null
	brew install --cask cargo
}

function install_docker() {
	# https://apple.stackexchange.com/questions/373888/how-do-i-start-the-docker-daemon-on-macos/373914#373914
	brew install --cask docker virtualbox
	brew install docker-machine
	docker-machine create --driver virtualbox default
	docker-machine restart
	eval "$(docker-machine env default)" # This might throw an TSI connection error. In that case run docker-machine regenerate-certs default
	docker-machine restart               # maybe needed
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

	brew install --cask
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

function remove_may_have_packages() {
	brew remove --force --ignore-dependencies "${BREW_PACKAGES_MAY_HAVE[*]}"
	brew remove --force --ignore-dependencies --cask "${BREW_CASK_PACKAGES_MAY_HAVE[*]}"
}
