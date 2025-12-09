#!/bin/sh
make install CFLAGS+="-Os -march=native -mtune=native -fstrict-aliasing" && make clean

ln -s $(realpath ./st-urlhandler) ~/.local/bin 2>/dev/null
ln -s $(realpath ./st-copyout   ) ~/.local/bin 2>/dev/null
