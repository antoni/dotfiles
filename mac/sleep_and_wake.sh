#!/usr/bin/env bash

# Connect and connect/disconnect Bluetooth headphones on wake/sleep
# To find out the ID of the device running:
# blueutil --connected

# TODO: Move to some constants
HEADPHONES_BLUETOOTH_DEVICE_ID="88-c9-e8-10-28-75"
BLUEUTIL_BIN=/usr/local/bin/blueutil

function sleep() {
	# if [ ! "$($BLUEUTIL_BIN --is-connected $HEADPHONES_BLUETOOTH_DEVICE_ID)" -eq 0 ]; then
	# 	$BLUEUTIL_BIN --disconnect $HEADPHONES_BLUETOOTH_DEVICE_ID \
	# 		--info $HEADPHONES_BLUETOOTH_DEVICE_ID
	# fi

	# Just turn Bluetooth off
	$BLUEUTIL_BIN --power 0
}

function wake() {
	if [ "$($BLUEUTIL_BIN --power)" -eq 0 ]; then
		echo Powering Bluetooth ON

		$BLUEUTIL_BIN --power 1
		# Wait till Bluetooth is ON
		/bin/sleep 3
	fi

	$BLUEUTIL_BIN --connect $HEADPHONES_BLUETOOTH_DEVICE_ID \
		--info $HEADPHONES_BLUETOOTH_DEVICE_ID
}
