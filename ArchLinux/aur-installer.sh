#!/bin/sh
./install.sh 'git base-devel'

PWD="$(pwd)"
cd /tmp
git clone 'https://aur.archlinux.org/yay.git' && cd yay
makepkg --noconfirm -si && cd /tmp && rm -rf yay
cd "$PWD"
