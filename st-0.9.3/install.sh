#!/bin/sh
make install CFLAGS+="-O3 -march=native -mtune=native -fstrict-aliasing" && make clean

