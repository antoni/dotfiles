#!/usr/bin/env bash

set -Eeuo pipefail

export DEBIAN_FRONTEND=noninteractive

MUST_HAVE=(software-properties-common
	build-essential flex bison libssl-dev libelf-dev git dwarves
	nmap
)

APT_PACKAGES=(apache2
	apt-cacher-ng
	ubuntu-release-upgrader-core
	vim
	neovim
	wireguard-tools
	neovim
	tmux
	docker
	btop
	hexyl
	htop
	rclone
	tree
	pkg-config
	expect
	libssl-dev
	borgbackup
	borgmatic
	fuse
	nginx
	figlet
	parallel
	graphviz
	jq
	ipsvd
	ascii
	iperf3
	pwgen
	watchman
	qemu-utils
	tesseract-ocr
	libsecret-tools
	maven
	flatpak
	gitk
	# BEGIN Python depdendencies
	libpython3-dev
	libdbus-1-dev
	libglib2.0-dev
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
	libhivex-bin
	wordnet
	zbar-tools
	audacity
	libcups2-dev
	zip
	git-lfs
	librecad
	7zip
	libasound2
	jpegoptim
	default-jdk
	scala
	cmake
	cryptsetup
	libxml2-utils
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
	exfatprogs
	ubuntu-restricted-extras
	libsecret-tools
)

# Install packages that require some custom configuration (like accepting the license etc.)
function install_custom_packages() {
	# Accept the licence
	echo virtualbox-ext-pack virtualbox-ext-pack/license select true |
		sudo debconf-set-selections
	sudo apt install --assume-yes virtualbox-ext-pack
}

# Pre-accept the Microsoft Core Fonts EULA so that
# `ttf-mscorefonts-installer` (pulled in by `ubuntu-restricted-extras`)
# installs without displaying an interactive license prompt.
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" \
    | sudo debconf-set-selections

echo 'apt-cacher-ng apt-cacher-ng/tunnelenable boolean false' | sudo debconf-set-selections

sudo apt \
	-qq -o=Dpkg::Use-Pty=0 install --assume-yes "${MUST_HAVE[@]}"
sudo apt \
	-qq -o=Dpkg::Use-Pty=0 install --assume-yes "${APT_PACKAGES[@]}"

install_custom_packages
