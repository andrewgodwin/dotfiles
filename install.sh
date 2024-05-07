#!/bin/bash

# Get current directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Link dotfiles
ln -sf $SCRIPT_DIR/.bashrc $HOME/.bashrc
ln -sf $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -sf $SCRIPT_DIR/.gitexclude $HOME/.gitexclude
ln -sf $SCRIPT_DIR/.screenrc $HOME/.screenrc
ln -sf $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf

# Install pyenv and friends
if [ ! -d $HOME/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi
if [ ! -d $(pyenv root)/plugins/pyenv-virtualenv ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi

# Install common packages
apt-get install -y build-essential python3-pip
