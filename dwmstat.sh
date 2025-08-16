#!/bin/sh
TZ="America/New_York"
while :; do
    CLK="$(date +"%A %I:%M %p - %m/%d")"
    xsetroot -name "$CLK"
    sleep 1
done

