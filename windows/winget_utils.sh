#!/usr/bin/env bash

WINGET_ALIAS="winget.exe"
WINGET_COMMAND_LIST="$WINGET_ALIAS list"
WINGET_COMMAND_SEARCH="$WINGET_ALIAS search"

# don't install an already installed package
WINGET_COMMAND_INSTALL="$WINGET_ALIAS install \
--no-upgrade \
--accept-source-agreements \
--accept-package-agreements \
--exact \
--id "

WINGET_COMMAND_INSTALL_NONEX="$WINGET_ALIAS install --id "

WINGET_COMMAND_UNINSTALL="$WINGET_ALIAS uninstall \
--exact \
--id "
