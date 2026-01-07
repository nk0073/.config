#!/bin/bash


CHECK_FILE_RAN=~/.local/share/.____12974691041jnni32@212479.plky.srcipt.ran

if [ -e $CHECK_FILE_RAN ]; then 
    echo "it's not your first time runing this script"   
    exit 2
fi
rm $CHECK_FILE_RAN 

mkdir -p ~/.local/bin
mkdir -p ~/.local/share

ldd /bin/ls | grep musl 2>&1 /dev/null
is_glibc=$1

lspci | grep -i nvidia 2>&1 /dev/null
is_mesa=$1

sudo xbps-install -Syu
sudo xbps-install -Syu void-repo-nonfree 

# for some reason, line breaking ignores the pakacges on the next line
sudo xbps-install -y clang git unzip ninja cmake git rsync patch
sudo xbps-install -y neovim firefox telegram-desktop xcompmgr xorg-minimal xorg-fonts
sudo xbps-install -y xf86-input-evdev xf86-input-joystick xf86-input-libinput xtools dbus elogind
sudo xbps-install -y feh noto-fonts-ttf noto-fonts-emoji xdg-desktop-portal xdg-desktop-portal-gtk
sudo xbps-install -y xclip xset pavucontrol pipewire redshift setxkbmap lldb xsetroot
sudo xbps-install -y libXinerama-devel libXft-devel libX11-devel pkg-config freetype-devel
sudo xbps-install -y zip unzip flatpak pulseaudio playerctl fastfetch btop keepassxc cronie
sudo xbps-install -y man-pages-devel man-pages-posix noto-fonts-cjk libXrandr-devel libXpm-devel imlib2-devel

# xf86-input-mtrack xf86-input-synaptics
# maybe those 2 too, if on a laptop

if [[ "$1" != "-compact" ]]; then
    sudo xbps-install -Syu void-repo-multilib{,-nonfree}
    sudo xbps-install -y qbittorrent wireguard steam lutris nitrogen
    sudo xbps-install -y libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit libva-32bit 

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
elif lspci -k | grep -EA3 'VGA|3D|Display' | grep -q 'AMD'; then
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
ln -s $(realpath scripts/*) ~/.local/bin

# font
mkdir -p ~/.local/share/fonts
wget -P ~/.local/share/fonts https://github.com/IdreesInc/Miracode/releases/download/v1.0/Miracode.ttf
fc-cache -fv


# flatpak
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y flathub com.spotify.Client org.vinegarhq.Sober
flatpak mask com.spotify.Client

# spotify fix
bash <(curl -sSL https://spotx-official.github.io/run.sh) -fh

# packer (nvim)
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# display manager
sudo xbps-install -y greetd tuigreet
sudo ln -s /etc/sv/greetd /var/service
cat << EOF > /etc/greetd/config.toml
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 2

# The default session, also known as the greeter.
[default_session]

# `agreety` is the bundled agetty/login-lookalike. You can replace `/bin/sh`
# with whatever you want started, such as `sway`.
command = "tuigreet --cmd /usr/bin/startx"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to be
# in the `video` group.
user = "_greeter"
EOF


touch $CHECK_FILE_RAN # random file to check if the script has ran before
exit 0

