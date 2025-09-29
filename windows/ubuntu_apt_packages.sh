#!/usr/bin/env bash

MUST_HAVE=(software-properties-common
	build-essential flex bison libssl-dev libelf-dev git dwarves
	nmap
)

APT_PACKAGES=(apache2
	apt-cacher-ng
	ubuntu-release-upgrader-core
	vim
	neovim
	tmux
	docker
	btop
	htop
	rclone
	fuse
	nginx
	figlet
	parallel
	graphviz
	jq
	ascii
	watchman
	qemu-utils
	tesseract-ocr
	libsecret-tools
	ffmpeg
	maven
	flatpak
	gitk
	# BEGIN Python depdendencies
	libpython3-dev
	libdbus-1-dev
	glib-2.0
	libcairo2-dev
	libgirepository1.0-dev
	libsystemd-dev
	# END Python depdendencies
	qpdf
	poppler-utils
	speedtest-cli
	traceroute
	mdns-scan
	mc
	pv
	xsel
	exiftool
	rand
	ethtool
	wakeonlan
	wkhtmltopdf
	cargo
	librsvg2-bin
	mysql-client
	inkscape
	advancecomp
	geoip-bin
	webp
	subversion
	tig
	python3-
	python-setuptools
	python3-setuptools
	python3-dev
	libhivex-bin
	wordnet
	libcups2-dev
	libimage-exiftool-perl
	zip
	git-lfs
	librecad
	p7zip
	libasound2
	default-jdk
	scala
	cmake
	shellcheck
	build-essential cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev
	libssl-dev ruby-dev
	ruby-full build-essential zlib1g-dev
	libtool
	haveged
	freerdp2-x11 rdesktop
	httrack
	clang-tidy
	webhttrack
	g++ automake autoconf libtool cmake
	libboost-dev libboost-system-dev libboost-filesystem-dev libboost-regex-dev
	libboost-program-options-dev libboost-iostreams-dev libboost-serialization-dev
	yamllint
	tree
	dos2unix
	libreadline-dev lib32readline8 lib32readline-dev
	virtualbox
	virtualbox-dkms
	dotnet-sdk-6.0
	exfat-fuse
	exfat-utils
	ubuntu-restricted-extras
	ffmpeg
)

# Install packages that require some custom configuration (like accepting the license etc.)
function install_custom_packages() {
	# Accept the licence
	echo virtualbox-ext-pack virtualbox-ext-pack/license select true |
		sudo debconf-set-selections
	sudo apt install --assume-yes "${MUST_HAVE[@]}"
	virtualbox-ext-pack
}

DEBIAN_FRONTEND=noninteractive sudo apt \
	-qq -o=Dpkg::Use-Pty=0 install --assume-yes "${MUST_HAVE[@]}"
DEBIAN_FRONTEND=noninteractive sudo apt \
	-qq -o=Dpkg::Use-Pty=0 install --assume-yes "${APT_PACKAGES[@]}"

install_custom_packages
