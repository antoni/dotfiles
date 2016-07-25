#!/bin/bash

# Install required packages
PACKAGES=(slock xbindkeys haskell clang vim vim-X11 rdesktop tigervnc make xpdf sysstat vim-enhanced vim-X11 make cmake gitk)
OPTIONAL_PACKAGES=(qt-devel)

if [ -f /etc/debian_version ]; then
    echo "Installing required packages on Debian"
    apt-get install -y $PACKAGES
    echo "This is debian based distro"
elif [ -f /etc/redhat-release ]; then
    echo "Installing required packages on Fedora"
    dnf install -y $PACKAGES
else
    echo "TODO: Mac OS X install"
fi
