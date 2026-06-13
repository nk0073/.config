#!/bin/sh

export GTK_THEME=FlatColor
export GTK_CSD=0
export QT_QPA_PLATFORMTHEME=xdgdesktopportal

redshift -l 40.7:-74.0 -t 6800:2600 &

picom &
flameshot &
setsid -f pipewire </dev/null >/tmp/pipewire.log 2>&1
slstatus & 
playerctld daemon &

env GTK2_RC_FILES=/etc/gtk-2.0/gtkrc parcellite >/dev/null 2>&1 &

exec dbus-run-session -- /usr/local/bin/dwm
