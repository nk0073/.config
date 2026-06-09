# My void linux setup
I barely update it, but some useful stuff is in the __once_setup.sh script which is somewhat
broken (for hardware specific stuff i think, so i included what needs to be installed below) and 
not properly updated. Mostly it's just suckless tools and dependencies for them and neovim, everything else
are fonts and apps I may not even use.



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

### Rust-analyzer

```sh
rustup component add rust-src
rustup component add rust-analyzer
```
