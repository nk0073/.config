#!/bin/sh

CHECK_FILE_RAN=~/.config/____12974691041jnni32@212479.plky.srcipt.ran

if [ -e $CHECK_FILE_RAN ]; then 
    echo "it's not your first time runing this script"   
    exit 2
fi
rm $CHECK_FILE_RAN 

if [ "$(id -u)" -ne 0 ]; then
    echo "run the script as root."
    exit 1
fi

sudo xbps-install -Syu
sudo xbos-install -Sy void-repo-multilib void-repo-nonfree void-repo-multilib-nonfree
sudo xbps-install -Sy python clang git unzip ninja cmake git iotop rsync \
    libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit \
    neovim firefox telegram-desktop kitty thunar qbittorrent wireguard \
    steam lutris nitrogen xcompmgr 

# wip



touch $CHECK_FILE_RAN # random file to check if the script has ran before

exit 0
