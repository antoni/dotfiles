#!/bin/bash
if [[ -e Makefile ]]; then
	sudo make clean install
else
	echo "Error: No Makefile present"
fi

# Arch
# makepkg -efi --skipinteg --noconfirm
