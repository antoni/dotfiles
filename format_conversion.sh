#!/usr/bin/env bash

# Resize image, keep aspect ratio and fill blank space
function jpg_to_png() {
	local input="$1"
	local output="$2"
	convert "$input" -resize 200x200 -background white -gravity center -extent 200x200 $output
}

alias heic_to_jpg='magick mogrify -monitor -format jpg *.HEIC'

# Converts SVG to PNG
# Usage svg_to_png input_image_path [output_image_height]
function svg_to_png() {
	local -r filename=$(filename_without_extension "$1")
	local output_filename=$filename.png
	local output_image_height=${2:-32}
	rsvg-convert -h "$output_image_height" "$1" >"$output_filename" && echo "Successfully created $output_filename" || echo "Error converting $1 to $output_filename"
}

function webp_to_png() {
	local -r filename=$(filename_without_extension "$1")
	local output_filename=$filename.png
	local output_image_height=${2:-32}
	dwebp "$1" -o "$output_filename"
}

function pdf_to_jpg() {
	pdfimages -j "$1" page
}
