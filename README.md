void setup

**a lot of stuff I haven't got my hands on yet**

## Void setup (installs everything needed below too)

todo: make it an sh script

todos

ly build script

waybar build script with tray and network


basic stuff
```sh
sudo xpbs-install -Su
sudo xbos-install -Sy void-repo-multilib void-repo-nonfree void-repo-multilib-nonfree
sudo xbps-install -Sy python nodejs clang git unzip ninja meson cmake git \
    libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit \
    neovim firefox telegram-desktop kitty thunar \
    steam lutris # now this part isn't necessary if the setup is non game related
```

some stuff not from xbps here
```sh
# vesktop
mkdir -p ~/bin
cd ~/bin
curl -JL https://vencord.dev/download/vesktop/amd64/tar -o vesktop.tar.gz
tar xvf vesktop.tar.gz
rm vesktop.tar.gz
ln -s "$(realpath vesktop/vesktop)" /usr/bin/vesktop
cat > ~/.local/share/applications/vesktop.desktop <<'EOF'
[Desktop Entry]
Name=Vesktop
Comment=Discord client
Exec=/usr/bin/vesktop
Icon=utilities-terminal
Type=Application
Categories=Network;
Terminal=false
StartupNotify=true
StartupWMClass=vesktop
EOF
```

NVIDIA
```sh
sudo xbps-install -Sy nvidia nvidia-libs nvidia-libs-32bit
```

AMD
```sh
xbps-install -Sy mesa mesa-dri mesa-dri-32bit mesa-vulkan-radeon mesa-vulkan-radeon-32bit
```

INTEL
```sh
xbps-install -Sy mesa mesa-dri mesa-dri-32bit mesa-vulkan-intel mesa-vulkan-intel-32bit
```

### VM
## Hyprland
not done yet
```sh
echo repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc | sudo tee /etc/xbps.d/hyprland-void.conf
sudo xbps-install -S
sudo xbps-install -Sy hyprland hyprland-devel xdg-desktop-portal-hyprland pulseaudio hyprlock slurp wl-clipboard \
    swww wofi wlsunset qt5-wayland
```

## i3wm
haven't even started

## Nvim setup 

Arch:
```sh
sudo pacman -Syu --noconfirm && sudo pacman -S --noconfirm clang nodejs npm python-pip git unzip neovim
```

then install packer

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Then nvim into nvim/packer.lua
and run these in order:
```
:so
:PackerSync
```

Restart neovim. Wait for everything to install.

### Rust

***DONT INSTALL rust-analyzer WITH MASON.***
Just use this
```sh
rustup component add rust-src
rustup component add rust-analyzer
```
