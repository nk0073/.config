#!/bin/bash

# Usage: ./wallpaper.sh <screen_number> <wallpaper_id> &
# Example: ./wallpaper.sh 1 2818870173 &

SCREEN_NUM="$1"
WALLPAPER_ID="$2"

# Map screen number to actual screen name
if [ "$SCREEN_NUM" = "1" ]; then
    SCREEN_NAME="HDMI-A-1"
elif [ "$SCREEN_NUM" = "2" ]; then
    SCREEN_NAME="DP-3"
else
    echo "Invalid screen number: $SCREEN_NUM. Use 1 for HDMI-A-1 or 2 for DP-3."
    exit 1
fi

# Run the wallpaper engine with desired options
__GL_THREADED_OPTIMIZATIONS=0 linux-wallpaperengine \
    --silent \
    --noautomute \
    --fps 60 \
    --scaling stretch \
    --no-fullscreen-pause \
    --screen-root "$SCREEN_NAME" "$WALLPAPER_ID"

