#!/bin/bash

# Install required packages
PACKAGES=(slock xbindkeys haskell clang vim vim-X11 rdesktop tigervnc make xpdf sysstat
<<<<<<< 13fe9f389d856e5e6c9758eb33b8cfea57ed7069
vim-enhanced vim-X11 make cmake gitk vlc st okular xdotool xbindkeys xautomation mosh
libreoffice cscope ctags perf pavucontrol jq dmidecode xsel)
OPTIONAL_PACKAGES=(qt-devel transmission-remote-* transmission-daemon)

NET_TOOLS=(nmap-ncat)

HASKELL=(ghc ghc-Cabal cabal-install)

LATEX=(texlive-listing texlive-pgfopts)

FEDORA=(gnome-icon-theme system-config-printer libreoffice-langpack-pl boost-devel squashfs-tools glibc-devel ghc-ShellCheck pykickstart ImageMagick-devel)
RXVT=(rxvt-unicode rxvt-unicode-ml rxvt-unicode-256color rxvt-unicode-256color-ml)

DEBIAN=(gnome-icon-theme-full boost-dev imagemagick)

KERNEL_DEV=(cscope exuberant-ctags)

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


# Video and audio codes (Fedora)

su -c 'dnf install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

sudo dnf update

sudo dnf install -y gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 x264 vlc  smplayer
