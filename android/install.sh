#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME"/dotfiles

mkdir -p tmp

source "$DOTFILES_DIR"/utils.sh
source "$DOTFILES_DIR"/colors.sh

APPLICATIONS=(https://play.google.com/store/apps/details?id=com.twitter.android
	https://play.google.com/store/apps/details?id=org.telegram.messenger
	https://play.google.com/store/apps/details?id=com.instagram.android
	https://play.google.com/store/apps/details?id=com.pinterest
	https://play.google.com/store/apps/details?id=com.snapchat.android
	https://play.google.com/store/apps/details?id=com.lastpass.lpandroid
	https://play.google.com/store/apps/details?id=com.Slack
	https://play.google.com/store/apps/details?id=com.zhiliaoapp.musically
	https://play.google.com/store/apps/details?id=org.thoughtcrime.securesms
	https://play.google.com/store/apps/details?id=pl.gov.cez.mojeikp
	https://play.google.com/store/apps/details?id=pl.neptis.yanosik.mobi.android
	https://play.google.com/store/apps/details?id=com.Slack
	https://play.google.com/store/apps/details?id=com.zhiliaoapp.musically
	https://play.google.com/store/apps/details?id=org.thoughtcrime.securesms
	https://play.google.com/store/apps/details?id=com.whatsapp
	https://play.google.com/store/apps/details?id=com.whatsapp.w4b
	https://play.google.com/store/apps/details?id=com.todoist
	https://play.google.com/store/apps/details?id=com.google.android.calendar
	https://play.google.com/store/apps/details?id=com.soundcloud.android
	https://play.google.com/store/apps/details?id=com.bandcamp.android
	https://play.google.com/store/apps/details?id=com.nordvpn.android
	https://play.google.com/store/apps/details?id=com.x8bit.bitwarden
	https://play.google.com/store/apps/details?id=com.shazam.android
	https://play.google.com/store/apps/details?id=com.reddit.frontpage
	https://play.google.com/store/apps/details?id=com.strava
	https://play.google.com/store/apps/details?id=org.mozilla.firefox
	https://play.google.com/store/apps/details?id=com.asana.app
	https://play.google.com/store/apps/details?id=com.linkedin.android
	https://play.google.com/store/apps/details?id=com.deepl.mobiletranslator
	https://play.google.com/store/apps/details?id=tv.twitch.android.app
	https://play.google.com/store/apps/details?id=com.tailscale.ipn
	https://play.google.com/store/apps/details?id=org.torproject.torbrowser
	https://play.google.com/store/apps/details?id=com.ubercab
	https://play.google.com/store/apps/details?id=ee.mtakso.client
	https://play.google.com/store/apps/details?id=volumio.browser.Volumio
	https://play.google.com/store/apps/details?id=com.discogs.app
	https://play.google.com/store/apps/details?id=com.linkedin.android
	https://play.google.com/store/apps/details?id=ch.protonmail.android
	https://play.google.com/store/apps/details?id=net.openvpn.openvpn
	https://play.google.com/store/apps/details?id=com.intsig.camscanner
	https://play.google.com/store/apps/details?id=com.microsoft.office.officelens
	https://play.google.com/store/apps/details?id=com.adobe.scan.android
	https://play.google.com/store/apps/details?id=com.microsoft.copilot
	https://play.google.com/store/apps/details?id=com.openai.chatgpt
	https://play.google.com/store/apps/details?id=me.proton.android.drive)

APPLICATIONS_PL=(https://play.google.com/store/apps/details?id=pl.znanylekarz
	https://play.google.com/store/apps/details?id=net.booksy.customer
	https://play.google.com/store/apps/details?id=pl.mbank
	https://play.google.com/store/apps/details?id=pl.otomoto
	https://play.google.com/store/apps/details?id=pl.otodom
	https://play.google.com/store/apps/details?id=com.fixly.android.user
	https://play.google.com/store/apps/details?id=pl.inpost.inmobile
	https://play.google.com/store/apps/details?id=pl.tablica)

# These need to be manually installed due to "Your device is not compatible with this item" error
APPLICATIONS_MANUAL_INSTALL=(https://play.google.com/store/apps/details?id=com.facebook.katana
	https://play.google.com/store/apps/details?id=pl.allegro
	https://play.google.com/store/apps/details?id=com.revolut.revolut
)

function authorize_using_oauth_token() {
	printf "Open this URL to get oauth_token cookie value:\n%s\n" "https://accounts.google.com/embedded/setup/v2/android"
	echo -n Oauth token:
	read -rs oauth_token
	# local -r oauth_token="$1"

	# This directory is hardcoded in 'google-play-apk-downloader'
	mkdir -p ~/google-play
	./google-play-apk-downloader -o "$oauth_token"
	# Note: -b 2 sets correct ABI interface
	./google-play-apk-downloader -d -b 2
}

function download_application() {
	local -r application_name="$1"

	# Note: -b 2 sets correct ABI interface
	version_code=$(./google-play-apk-downloader -b 2 -i "$application_name" \
		2>/dev/null |
		grep "version code" |
		cut -d= -f 2 |
		xargs)

	./google-play-apk-downloader -b 2 -i "$application_name" -a
	./google-play-apk-downloader -b 2 -i "$application_name" -v "$version_code"
}

function install_application() {
	local -r application_name="$1"
	# Install all APK files downloaded for given application
	adb.exe install-multiple "$application_name-"*.apk
}

function main() {
	if [ ! -f ~/google-play/arm64-v8a.bin ]; then
		echo "File for required ABI does not exist, running authorization"

		authorize_using_oauth_token
	fi

	for application in "${APPLICATIONS[@]}"; do
		application_name=${application/?*\?id=/}
		printf "Installing '%s'\n" "$application_name"
		download_application "$application_name"
		install_application "$application_name"
	done

	for application in "${APPLICATIONS_PL[@]}"; do
		application_name=${application/?*\?id=/}
		printf "Installing '%s'\n" "$application_name"
		download_application "$application_name"
		install_application "$application_name"
	done
}

main
