#!/bin/bash

OS=$(uname -s)

if [ "$OS" = "Linux" ]; then
    # Debian
    if [ -f "/usr/bin/apt" ]; then
        sudo apt update
        sudo apt install -y git
    fi
    # WSL
    if [ -d /mnt/c ]; then
        ln -s /mnt/c/Users/Andrew ~/WinUser
        ln -s ~/WinUser/Sync Sync
        ln -s ~/WinUser/Downloads Downloads
    fi
elif [ "$OS" = "Darwin" ]; then
    # MacOS
    if ! xcode-select -p &> /dev/null; then
        echo "Error: Xcode Command Line Tools are not installed."
        echo "Install them with: xcode-select --install"
        exit 1
    fi
fi

mkdir -p ~/Programs
cd ~/Programs
git clone https://github.com/andrewgodwin/dotfiles
cd dotfiles
