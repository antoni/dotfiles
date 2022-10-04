#!/usr/bin/env bash

# alias pg_start="launchctl load ~/Library/LaunchAgents"
# alias pg_stop="launchctl unload ~/Library/LaunchAgents"

# ln -sfv /opt/homebrew/opt/postgresql/*.plist ~/Library/LaunchAgents

# Note: Homebrew postgres currently creates an account with the same name as the installing user, but no password
brew install postgresql

# Using PostgreSQL service
# brew services start postgresql
# brew services stop postgresql
# brew services info postgresql


