#!/bin/sh
export GTK_THEME=Silvery-GTK
export GTK_CSD=0
export QT_QPA_PLATFORM=xcb

exec dbus-run-session -- /usr/local/bin/dwm
