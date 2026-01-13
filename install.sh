#!/bin/bash

# Get current directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Link dotfiles
ln -sf $SCRIPT_DIR/.bashrc $HOME/.bashrc
ln -sf $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -sf $SCRIPT_DIR/.gitexclude $HOME/.gitexclude
ln -sf $SCRIPT_DIR/.screenrc $HOME/.screenrc
ln -sf $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.ssh
ln -sf $SCRIPT_DIR/ssh-config $HOME/.ssh/config

# Install common packages on Debian/Ubuntu
if [ -f "/usr/bin/apt" ]; then
    sudo apt-get update
    sudo apt-get install -y $(cat "$SCRIPT_DIR/packages/ubuntu-server-apt")
fi

# Install common packages on Ublue/Bazzite
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    brew install $(cat "$SCRIPT_DIR/packages/bazzite-desktop-homebrew")
    flatpak install $(cat "$SCRIPT_DIR/packages/bazzite-desktop-flatpak")
fi

# Install pyenv and friends
if [ ! -d $HOME/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    eval "$(pyenv init -)"
fi
if [ ! -d $(pyenv root)/plugins/pyenv-virtualenv ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi
