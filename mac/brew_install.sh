#!/usr/bin/env bash

BREW_PACKAGES_MUST_HAVE=(
	gawk
	gnu-sed
	gnu-indent
	gnu-tar
	coreutils
	findutils
	gnutls
	openjdk
	grep
	bitwarden-cli
	jd
	ascii
	gpg
	exiftool
	shfmt
	zrok
	yarn
	kotlin
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
	colima
	certbot
	i2p
	i2pd
	cog
	gron
	mas
	certbot
	docker-compose
	dialog
	haskell-stack
	ykman
	yubico-piv-tool
	autojump
	azcopy
	yarn-completion
	git-lfs
	dockutil
	gnumeric
	testdisk
	pv
	handbrake
	terminal-notifier
	bat
	advancecomp
	hyperfine
	datamash
	php
	mplayer
	gitleaks
	pillow
	emscripten
	deno
	graphviz
	gifski
	binaryen
	gifsicle
	git-gui
	carthage
	pipenv
	starship
	woff2
	act
	hashcat
	eth-p/software/bat-extras
	qpdf
	wireguard-tools
	esptool
	rtmpdump
	fop
	fontforge
	xz
	dnsmasq
	dvc
	docker-machine
	ccat
	rustup-init
	tor
	infracost
	pass
	blueutil
	rtorrent
	newsboat
	brightness
	sleepwatcher
	cocoapods
	entr
	ansible
	lastpass-cli
	scala
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
	rustscan
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
	chromium
	ngrok
	zoom
	rar
	duckduckgo
	espanso
	iterm2
	textmate
	microsoft-teams
	atom
	chatgpt
	google-cloud-sdk
	spotify
	temurin
	raycast
	mpv
	whatsapp
	telegram
	visual-studio-code
	signal
	pym-player
	mactex
	omnidisksweeper
	firefox
	firefox@developer-edition
	brave-browser
	vlc
	macdown
	slack
	libreoffice
	microsoft-office
	tor-browser
	openvpn-connect
	tailscale
	cursor
)

BREW_CASK_PACKAGES_MAY_HAVE=(wine-stable
	texshop
	# VPNs
	surfshark
	nordvpn
	mullvadvpn
	microsoft-remote-desktop
	duckduckgo
	xournal-plus-plus
	teamviewer
	rustdesk
	docker
	iconjar
	iina
	electrum
	http-toolkit
	veracrypt
	streamlabs-obs
	cloudflare-warp
	anaconda
	opera-gx
	disk-drill
	azure-data-studio
	ledger-live
	caffeine
	lens
	bitwarden
	roblox
	mullvad-browser
	messenger
	tableplus
	qlvideo
	zulip
	powershell
	rstudio
	angry-ip-scanner
	paragon-ntfs
	librecad
	freecad
	hammerspoon
	cyberduck
	mountain-duck
	transmit
	proxyman
	raycast
	jubler
	postman
	obsidian
	bettertouchtool
	asana
	origin
	charles
	blender
	mitmproxy
	elmedia-player
	daisydisk
	binance
	image2icon
	miro
	figma
	clion
	qcad
	altair-graphql-client
	bitwarden
	adobe-creative-cloud
	stretchly
	emacs
	dogecoin
	quarto
	little-snitch
	imazing
	discord
	github
	aquamacs
	WebPQuickLook
	studio-3t
	obs
	qlstephen
	starcraft
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
	koa11y
	mysides
	jetbrains-toolbox
	fontforge
	macpass
	transmission
	transmission-remote-gui
	gpg-suite
	db-browser-for-sqlite
	tunnelblick
	mounty
	wireshark-chmodbpf
	transmission
	nordvpn
	owasp-zap
	the-unarchiver
	google-chrome@canary
	google-drive
	postman
	keybase
	macs-fan-control
	cleanmymac
	flux
	google-earth-pro
	omnigraffle
	mysqlworkbench
	sublime-text
	the-unarchiver
	hyper
	gitkraken
	opera
	webstorm
	quip
	karabiner-elements
	android-studio
	pharo-project/pharo/pharo-launcher
	vagrant
	kicad
	audacity
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
	chsh -s "$(which bash)"

	brew install bash-completion

	# Brew service (launchd)
	brew tap homebrew/services

	# Packages needed to install other packages later
	brew install svn node npm

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

	# macFUSE
	brew install --cask macfuse

	brew tap gromgit/homebrew-fuse
	brew install ntfs-3g-mac

	# sdk_man_install
}

function install_packages_with_security_approvals() {
	brew install --cask virtualbox
}

function remove_may_have_packages_cask() {
	echo "${BREW_CASK_PACKAGES_MAY_HAVE[*]}" | xargs brew uninstall --force
}

function remove_may_have_packages_main() {
	echo "${BREW_PACKAGES_MAY_HAVE[*]}" | xargs brew uninstall --force
}

function remove_may_have_packages() {
	remove_may_have_packages_main
	remove_may_have_packages_cask
}

function is_package_installed() {
	local package_name="$1"
	brew list "$package_name"
}

# Installation:
# HOMEBREW_NO_AUTO_UPDATE=1 brew install "${BREW_PACKAGES_KINGA[*]}"
# HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "${BREW_CASK_PACKAGES_KINGA[*]}"
BREW_PACKAGES_KINGA=(
	docker
	tailscale
	bitwarden-cli
)

BREW_CASK_PACKAGES_KINGA=(
	bitwarden
	caffeine
	google-drive
	firefox
	firefox@developer-edition
	brave-browser
	iterm2
	vlc
	visual-studio-code
	duckduckgo
	raycast
	teamviewer
	rustdesk
	espanso
	pym-player
)

function check_missing_brew_packages() {
	local package_set="$1"
	shift
	local packages=("$@")
	local missing_packages=()

	printf "Checking %s\n" "$package_set"

	for package in "${packages[@]}"; do
		# Check if the package exists as a formula
		if ! brew info --formula "$package" &>/dev/null; then
			missing_packages+=("$package")
		fi
	done

	if [ ${#missing_packages[@]} -eq 0 ]; then
		echo "All packages are available in Homebrew."
	else
		echo "The following packages are missing from Homebrew:"
		for missing in "${missing_packages[@]}"; do
			echo "- $missing"
		done
	fi
}

function check_missing_brew_cask_packages() {
	local package_set="$1"
	shift
	local packages=("$@")
	local missing_packages=()

	printf "Checking %s\n" "$package_set"

	for package in "${packages[@]}"; do
		if ! brew info --cask "$package" &>/dev/null; then
			missing_packages+=("$package")
		fi
	done

	if [ ${#missing_packages[@]} -eq 0 ]; then
		echo "All packages are available in Homebrew."
	else
		echo "The following packages are missing from Homebrew:"
		for missing in "${missing_packages[@]}"; do
			echo "- $missing"
		done
	fi
}

function check_missing_packages() {
	check_missing_brew_packages "BREW_PACKAGES_MUST_HAVE" "${BREW_PACKAGES_MUST_HAVE[@]}"
	check_missing_brew_cask_packages "BREW_CASK_PACKAGES_MUST_HAVE" "${BREW_CASK_PACKAGES_MUST_HAVE[@]}"
	check_missing_brew_packages "BREW_PACKAGES_MAY_HAVE" "${BREW_PACKAGES_MAY_HAVE[@]}"
	check_missing_brew_cask_packages "BREW_CASK_PACKAGES_MAY_HAVE" "${BREW_CASK_PACKAGES_MAY_HAVE[@]}"
}
