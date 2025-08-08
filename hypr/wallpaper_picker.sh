#!/bin/bash

WALLPAPER_DIR=~/Pictures/wallpapers
SELECTED=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.png" \) | wofi --show dmenu --prompt "Wallpaper")

[ -n "$SELECTED" ] && swww img "$SELECTED" --transition-type grow --transition-step 30 --transition-fps 60

