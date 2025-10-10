#!/bin/sh

CHECK_FILE_RAN=~/.config/____12974691041212479.plky.srcipt.ran

rm $CHECK_FILE_RAN 2>/dev/null
if [ $? -ne 0 ]; then 
    echo "it's not your first time runing this script buddy forget about it"   
    exit 2
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "run the script as root."
    exit 1
fi

sudo xbps-install -Syu
sudo xbos-install -Sy void-repo-multilib void-repo-nonfree void-repo-multilib-nonfree
sudo xbps-install -Sy python nodejs clang git unzip ninja meson cmake git iotop vifm rsync \
    libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit \
    neovim firefox telegram-desktop kitty thunar qbittorrent wireguard \
    steam lutris 


touch $CHECK_FILE_RAN # random file to check if the script has ran before

exit 0
