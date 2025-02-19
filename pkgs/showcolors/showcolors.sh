#!/bin/env bash

for hex in "$@"; do
    printf "\e[48;2;%d;%d;%dm  %s  \e[0m\n" $((0x${hex:1:2})) $((0x${hex:3:2})) $((0x${hex:5:2})) "$hex"
done
