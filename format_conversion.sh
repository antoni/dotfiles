#!/usr/bin/env bash

# Resize image, keep aspect ratio and fill blank space
function jpg_to_png() {
	local input="$1"
	local output="$2"
	convert "$input" -resize 200x200 -background white -gravity center -extent 200x200 "$output"
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

  echo "Converting ${#files[@]} HEIC files to JPG using GNU parallel..."

  parallel 'magick {} {.}.jpg' ::: "${files[@]}"

  echo "✅ All conversions complete."

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

# flac2mp3: Convert FLAC files to MP3 while preserving ID3 tags
#
# Usage:
#   flac2mp3 file1.flac file2.flac ...
#   find . -name '*.flac' -print0 | xargs -0 flac2mp3
#
# Requires: metaflac, flac, lame

function flac2mp3() {
	local deps=(metaflac flac lame)
	for cmd in "${deps[@]}"; do
		if ! command -v "$cmd" >/dev/null 2>&1; then
			echo "Error: missing dependency: $cmd" >&2
			return 1
		fi
	done

	for f in "$@"; do
		[[ "$f" != *.flac ]] && continue
		[[ ! -f "$f" ]] && {
			echo "Skipping: $f (not found)"
			continue
		}

		album=$(metaflac --show-tag=album "$f" | sed 's/[^=]*=//')
		artist=$(metaflac --show-tag=artist "$f" | sed 's/[^=]*=//')
		year=$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')
		title=$(metaflac --show-tag=title "$f" | sed 's/[^=]*=//')
		genre=$(metaflac --show-tag=genre "$f" | sed 's/[^=]*=//')
		tracknumber=$(metaflac --show-tag=tracknumber "$f" | sed 's/[^=]*=//')

		out="${f%.flac}.mp3"
		echo "Converting: $f → $out"

		flac --decode --stdout "$f" | lame --preset extreme --add-id3v2 \
			--tt "$title" \
			--ta "$artist" \
			--tl "$album" \
			--ty "$year" \
			--tn "$tracknumber" \
			--tg "$genre" \
			- "$out"
	done
}

function md2pdf() {
	local -r filename=$(filename_without_extension "$1")
	pandoc --standalone --variable=papersize:a4 --variable=geometry:margin=1in --from=gfm -o "$filename".pdf "$filename".md
}

function pdf2md() {
	local -r filename=$(filename_without_extension "$1")
	docling "$filename.pdf" --ocr-lang pl --output $filename
}

function rst2pdf() {
	pandoc --standalone -V papersize:a4 -V geometry:margin=1in --from rst -o "$1".pdf "$1"
	open "$1".pdf
}

function md2html() {
  local infile="${1:--}"
  local outfile="${2:--}"
  pandoc -f markdown -t html "$infile" -o "$outfile"
}