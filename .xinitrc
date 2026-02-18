#!/bin/sh

export GTK_THEME=FlatColor
export GTK_CSD=0
export QT_QPA_PLATFORMTHEME=xdgdesktopportal

redshift -l 40.7:-74.0 -t 6800:2600 &

exec dbus-run-session -- /usr/local/bin/dwm
