# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cclear="printf '\e[3J\e[H\e[2J'"
alias v="nvim"
alias sagentsource="source ~/.local/bin/sagent"
alias rms="shred -uzn8"
alias ccp="xclip -selection clipboard" # stands for clipboard copy
alias du.="du -hs ./* | sort -rh"

PS1='[\u@\h \W]\$ '
# . "$HOME/.cargo/env"

p="/home/plky/projects"
ls="ls -Utp --color=auto"
rpi="plky@192.168.4.10"

JAVA_HOME=/usr/lib/jvm/default-jdk
EDITOR=nvim
# export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$HOME/.local/bin:$JAVA_HOME/bin:$PATH"
# export PATH="$HOME/.dotnet:$HOME/.dotnet/tools:$PATH"

source sagent

