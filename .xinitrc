#!/bin/sh
export GTK_THEME=Adwaita:dark
export GTK_CSD=0
export QT_QPA_PLATFORM=xcb
export DE="xfce" # kind of silly but it makes thunar work for everything

exec dbus-run-session -- /usr/local/bin/dwm
