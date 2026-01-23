#!/bin/bash

if [ -f "/usr/bin/apt" ]; then
    sudo apt update
    sudo apt install -y git
fi

if [ -d /mnt/c ]; then
    ln -s /mnt/c/Users/Andrew ~/WinUser
    ln -s ~/WinUser/Sync Sync
    ln -s ~/WinUser/Downloads Downloads
fi

mkdir -p ~/Programs
cd ~/Programs
git clone https://github.com/andrewgodwin/dotfiles
cd dotfiles
