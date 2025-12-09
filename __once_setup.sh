#!/bin/sh


CHECK_FILE_RAN=~/.local/share/.____12974691041jnni32@212479.plky.srcipt.ran

if [ -e $CHECK_FILE_RAN ]; then 
    echo "it's not your first time runing this script"   
    exit 2
fi
rm $CHECK_FILE_RAN 

ldd /bin/ls | grep musl 2>&1 /dev/null
is_glibc=$1

lspci | grep -i nvidia 2>&1 /dev/null
is_mesa=$1

sudo xbps-install -Syu
sudo xbps-install -Syu void-repo-nonfree 

sudo xbps-install -y clang git unzip ninja cmake git rsync \
    neovim firefox telegram-desktop thunar xcompmgr xorg-minimal xorg-fonts \
    xf86-input-evdev xf86-input-joystick xf86-input-libinput xtools dbus elogind \
    feh noto-fonts-ttf noto-fonts-emoji xdg-desktop-portal xdg-desktop-portal-gtk \
    xclip xset pavucontrol pipewire redshift setxkbmap
    

# xf86-input-mtrack xf86-input-synaptics
# maybe those 2 too, if on a laptop

if [[ "$1" != "-compact" ]]; then
    sudo xbps-install -Syu void-repo-multilib{,-nonfree}
    sudo xbps-install -y qbittorrent wireguard steam lutris nitrogen \
        libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit libva-32bit

    if [[ $is_mesa -eq 1 ]]; then
        sudo xbps-install mesa-dri-32bit vulkan-loader mesa-vulkan-radeon amdvlk
    else
        sudo xbps-install -y nvidia-libs-32bit 
    fi
fi

if [[ is_mesa -eq 1 ]]; then # mesa
    sudo xbps-install -y mesa-dri
else # nvidia
    sudo xbps-install -y nvidia
fi

# intel igpu
if lspci -k | grep -EA3 'VGA|3D|Display' | grep -i "Intel Corporation" > /dev/null; then
    sudo xbps-install -y intel-video-accel 
elif lspci -k | grep -EA3 'VGA|3D|Display' | grep -q 'AMD';
    sudo xbps-install -y xf86-video-amdgpu mesa-vaapi mesa-vdpau
fi

# session and seat manager
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/elogind/ /var/service/

# pipewire
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# dwm
cd ~/.config/dwm-6.6/
sudo make install && make clean

# st
cd ../st-0.9.3/
sudo ./install.sh; make clean


touch $CHECK_FILE_RAN # random file to check if the script has ran before

exit 0
