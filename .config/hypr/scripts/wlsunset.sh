#!/bin/bash

CONFIG="$HOME/.config/hypr/scripts/wlsunset_temp"
MIN_TEMP=1500
MAX_TEMP=6500
STEP=200
DEFAULT_TEMP=4000

if [[ -f "$CONFIG" ]]; then
    TEMP=$(<"$CONFIG")
else
    TEMP=$DEFAULT_TEMP
fi

if [[ $1 == "up" ]]; then
    TEMP=$((TEMP + STEP))
elif [[ $1 == "down" ]]; then
    TEMP=$((TEMP - STEP))
fi

if (( TEMP > MAX_TEMP )); then TEMP=$MAX_TEMP; fi
if (( TEMP < MIN_TEMP )); then TEMP=$MIN_TEMP; fi

echo $TEMP > "$CONFIG"

pkill wlsunset
wlsunset -t "$TEMP" -T "$MAX_TEMP" -l 40.7 -L -74.0 &

