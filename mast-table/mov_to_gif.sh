#!/bin/bash

# Convert a quicktime screen recording to a small-ish gif
#
# call signature: 
#     ./mov_to_gif.sh <filename>.mov
# 
# output will be saved to <filename>.gif 
#
# Requires ffmpeg and gifsicle, which you can install on OS X with:
#     brew install ffmpeg gifsicle

input_file=$1
input_file_strip_extension=$(echo "$input_file" | cut -d '.' -f 1)
output_file="$input_file_strip_extension.gif"
ffmpeg -i "$input_file" -vf "fps=8,scale=1200:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=256[p];[b][p]paletteuse=dither=floyd_steinberg" -f gif - | gifsicle -j -O3 --delay=5 > "$output_file"
echo "Done: '$input_file' converted to '$output_file'"
