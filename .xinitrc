#!/bin/sh
exec dbus-run-session -- dwm
# LOCALBIN
export PATH="$HOME/.local/bin:$PATH"
