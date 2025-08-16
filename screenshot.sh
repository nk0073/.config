#!/bin/bash

dir="$HOME/Pictures/Screenshot"
mkdir -p "$dir"

file="$dir/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

# select region (Esc cancels)
geom=$(slop -f "%g") || exit 1

# grab selection and save
maim -g "$geom" "$file"

# copy to clipboard
xclip -selection clipboard -t image/png -i "$file"

