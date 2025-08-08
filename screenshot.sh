#!/bin/bash

# create a dir if doesn't exist
mkdir -p ~/Pictures/Screenshot

filename=~/Pictures/Screenshot/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png

# screenshot of the selected area
grim -g "$(slurp)" "$filename"

# copy to clipboard
wl-copy --type image/png < "$filename"

