#!/usr/bin/env bash

APT_PACKAGES=(apache2
	vim
	tmux
	golang
	docker
	htop
	nginx
	parallel
	graphviz
	jq
	qemu-utils
	maven
	flatpak
	gitk
	poppler-utils
	mc
	exiftool
	rand
	subversion
	tig
	zip
	git-lfs
	librecad
	p7zip
	libasound2
	docker-compose
	default-jdk scala
	cmake
	git-lfs
	shellcheck
	build-essential cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev
	ruby-full build-essential zlib1g-dev
	python3-pip
	libtool
	haveged
	httrack
	clang-tidy
	webhttrack
	g++ automake autoconf libtool cmake libicu-dev
	libboost-dev libboost-system-dev libboost-filesystem-dev libboost-regex-dev libboost-program-options-dev libboost-iostreams-dev libboost-serialization-dev
	yamllint
	tree
	dos2unix
	libreadline-dev lib32readline8 lib32readline-dev
)

sudo apt install -y "${APT_PACKAGES[@]}"
