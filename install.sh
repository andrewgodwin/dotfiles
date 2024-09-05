#!/bin/bash

# Get current directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Link dotfiles
ln -sf $SCRIPT_DIR/.bashrc $HOME/.bashrc
ln -sf $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -sf $SCRIPT_DIR/.gitexclude $HOME/.gitexclude
ln -sf $SCRIPT_DIR/.screenrc $HOME/.screenrc
ln -sf $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf

# Install common packages
sudo apt-get update
sudo apt-get install -y build-essential \
    tmux \
    htop \
    keychain \
    python3-pip \
    python3-dev \
    python3-venv \
    libssl-dev \
    libreadline-dev \
    libncurses-dev \
    libbz2-dev \
    libjpeg-dev \
    libpng-dev \
    libffi-dev

# Install pyenv and friends
if [ ! -d $HOME/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    eval "$(pyenv init -)"
fi
if [ ! -d $(pyenv root)/plugins/pyenv-virtualenv ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi
