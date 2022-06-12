#!/usr/bin/env bash

HEADPHONES_BLUETOOTH_DEVICE_ID=cc-98-8b-93-48-5d
BLUEUTIL_BIN=/usr/local/bin/blueutil

function sleep() {
	if [ "$($BLUEUTIL_BIN --is-connected $HEADPHONES_BLUETOOTH_DEVICE_ID)" -eq 0 ]; then
		$BLUEUTIL_BIN --power 0
	else
		$BLUEUTIL_BIN --disconnect $HEADPHONES_BLUETOOTH_DEVICE_ID
	fi
}

function wake() {
	if [ "$($BLUEUTIL_BIN --power)" -eq 0 ]; then
		echo Powering Bluetooth ON
		$BLUEUTIL_BIN --power 1
		# Wait till Bluetooth is ON
		/bin/sleep 3
	fi
	$BLUEUTIL_BIN --connect $HEADPHONES_BLUETOOTH_DEVICE_ID
}
