#!/bin/bash

sudo apt-get install -y git

if [ -d /mnt/c ]; then
    ln -s /mnt/c/Users/Andrew ~/WinUser
    ln -s ~/WinUser/Sync Sync
    ln -s ~/WinUser/Downloads Downloads
fi

mkdir -p ~/Programs
cd ~/Programs
git clone https://github.com/andrewgodwin/dotfiles
cd dotfiles
