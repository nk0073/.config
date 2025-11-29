# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cclear="printf '\033[3J\033[H\033[2J'"
alias v="nvim"
alias sagentsource="source ~/.local/bin/sagent"
alias rms="shred -uzn8"

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

p="/home/plky/projects"
ls="ls -Utp --color=auto"
rpi="plky@192.168.4.10"

JAVA_HOME=/usr/lib/jvm/default-jdk
EDITOR=nvim
PATH="$HOME/.local/bin:$JAVA_HOME/bin:$PATH"

source sagent

