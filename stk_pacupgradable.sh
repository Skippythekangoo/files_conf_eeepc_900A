#!/usr/bin/env bash

# Script pour afficher le nombre de paquet upgradable via pacman

sudo pacman -Sy >> /dev/null
PACNUM=$(pacman -Qu | wc -l)

echo $PACNUM
