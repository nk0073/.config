#!/bin/sh

export GTK_THEME=Silvery-GTK
export GTK_ICON_THEME=Wings-Dark-Icons
export GTK_CSD=0
export QT_QPA_PLATFORMTHEME=xdgdesktopportal

exec dbus-run-session -- /usr/local/bin/dwm
