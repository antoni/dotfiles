#!/usr/bin/env bash

MUST_HAVE=(software-properties-common
	build-essential flex bison libssl-dev libelf-dev git dwarves
	nmap
)

APT_PACKAGES=(apache2
	ubuntu-release-upgrader-core
	vim
	tmux
	docker
	htop
	nginx
	parallel
	graphviz
	jq
	qemu-utils
	ffmpeg
	maven
	flatpak
	gitk
	poppler-utils
	mc
	pv
	exiftool
	rand
	wkhtmltopdf
	librsvg2-bin
	inkscape
	advancecomp
	geoip-bin
	webp
	subversion
	tig
	python3-pip
	python-setuptools
	python3-setuptools
	python3-dev
	libhivex-bin
	libcups2-dev
	libimage-exiftool-perl
	zip
	git-lfs
	librecad
	p7zip
	libasound2
	docker-compose
	default-jdk scala
	cmake
	shellcheck
	build-essential cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev
	ruby-full build-essential zlib1g-dev
	libtool
	haveged
	freerdp2-x11 rdesktop
	httrack
	clang-tidy
	webhttrack
	g++ automake autoconf libtool cmake libicu-dev
	libboost-dev libboost-system-dev libboost-filesystem-dev libboost-regex-dev libboost-program-options-dev libboost-iostreams-dev libboost-serialization-dev
	yamllint
	tree
	dos2unix
	libreadline-dev lib32readline8 lib32readline-dev
	virtualbox
	# TODO: This packages requires user to accept to licence
	# figure out how to dot it non-interactively
	virtualbox-ext-pack
	virtualbox-dkms
	dotnet-sdk-6.0
)

sudo apt install --assume-yes "${MUST_HAVE[@]}"
sudo apt install --assume-yes "${APT_PACKAGES[@]}"
