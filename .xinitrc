#!/bin/sh
export GTK_THEME=Adwaita:dark
exec dbus-run-session -- /usr/local/bin/dwm
