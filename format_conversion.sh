#!/usr/bin/env bash

# Resize image, keep aspect ratio and fill blank space
function jpg_to_png() {
	local input="$1"
	local output="$2"
	convert "$input" -resize 200x200 -background white -gravity center -extent 200x200 $output
}

function heic_to_jpg() {
	# Enable case-insensitive globbing and prevent errors on empty matches
	if [[ -n $ZSH_VERSION ]]; then
		setopt LOCAL_OPTIONS nocaseglob nullglob
	elif [[ -n $BASH_VERSION ]]; then
		shopt -s nocaseglob nullglob
	fi

	local files=(*.heic)

	if [[ ${#files[@]} -eq 0 ]]; then
		echo "No HEIC files found in the current directory."
		return 1
	fi

	echo "Converting ${#files[@]} HEIC files to JPG using ImageMagick..."

	for file in "${files[@]}"; do
		local base="${file%.*}"
		echo "  ➤ $file → ${base}.jpg"
		magick "$file" "${base}.jpg"
	done

	echo "✅ All conversions complete."

	# Restore glob settings is unnecessary due to LOCAL_OPTIONS in Zsh
	if [[ -n $BASH_VERSION ]]; then
		shopt -u nocaseglob nullglob
	fi
}

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

function mov_to_mp4() {
	local input_filename="$1"
	local -r filename=$(filename_without_extension "$1")
	local output_filename=$filename.mp4
	local fps=60

	ffmpeg -i "$input_filename" -loglevel error \
		-fflags +genpts -r $fps "$output_filename" &&
		echo "Successfully created $output_filename" ||
		echo "Error converting $1 to $output_filename"
}
