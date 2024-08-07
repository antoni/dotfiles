#!/usr/bin/env bash

function collage() {
	montage -density 300 -tile 2x0 -geometry +5+50 -border 10 ./*.png collage.png
}

function pixelate() {
	local filename="$1"
	name=$(filename_without_extension "$filename")
	local name

	extension=$(filename_extension "$filename")
	local extension

	convert -scale 10% -scale 1000% "$filename" "$name""_pixelated""$extension"
}

function remove_exif_data() {
	local filename=$1
	exiftool -Adobe:All= -all:all= -EXIF= "$filename"
}

function show_image_geo_location() {
	local -r image_path="$1"

	"$HOME"/scripts/images/get_geo_coordinates.sh "$image_path"
}

# Resizes image in-place
function resize_image() {
	local resize_arg=$1
	local input=$2
	mogrify -resize "$resize_arg" "$input"
}
