#!/bin/bash

# Get current directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Link dotfiles
ln -s $SCRIPT_DIR/.bashrc $HOME/.bashrc
ln -s $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -s $SCRIPT_DIR/.gitexclude $HOME/.gitexclude
