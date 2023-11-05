#!/bin/bash

# Get current directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Link dotfiles
ln -sf $SCRIPT_DIR/.bashrc $HOME/.bashrc
ln -sf $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -sf $SCRIPT_DIR/.gitexclude $HOME/.gitexclude
ln -sf $SCRIPT_DIR/.screenrc $HOME/.screenrc
