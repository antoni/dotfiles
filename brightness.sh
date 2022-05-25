#!/usr/bin/env bash

# Credit: https://www.reddit.com/r/linux/comments/268wcy/managing_brightness_on_i3wm/
function change_brightness() {
	# local file_brightness='/sys/class/backlight/intel_backlight/brightness'
	# local file_max='/sys/class/backlight/intel_backlight/max_brightness'
	# local cur=$(cat "$file_brightness")
	# local max=$(cat "$file_max")

	# if [ ! -w "$file_brightness" ]; then
	# echo "sudo needed"
	# exit 2
	# fi

	# new=$(($cur $1 $2))
	# new=$(($new>$max?$max:$new))
	# new=$(($new<0?0:$new))
	# echo $new > "$file_brightness"
	# echo "New brightness: $new/$max."
	true # FIXME: implement
}

# if [[ -z "$1" || -z "$2" ]]; then
# echo "Usage: brightness <-|+> <delta>"
# exit 1
# fi

# change_brightness $1 $2
