#!/bin/sh

export GTK_THEME=FlatColor
export GTK_CSD=0
export QT_QPA_PLATFORMTHEME=xdgdesktopportal


exec dbus-run-session -- /usr/local/bin/dwm
