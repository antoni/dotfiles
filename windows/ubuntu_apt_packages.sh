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
	shellcheck
	build-essential cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev
	ruby-full build-essential zlib1g-dev
	python3-pip
    haveged
    yamllint
    tree
)

sudo apt install -y ${APT_PACKAGES[@]}
