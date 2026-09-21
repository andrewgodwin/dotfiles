#!/bin/bash

# Parse arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <server|workstation>"
    exit 1
fi

MODE=$1

if [ "$MODE" != "server" ] && [ "$MODE" != "workstation" ]; then
    echo "Error: Mode must be 'server' or 'workstation'"
    echo "Usage: $0 <server|workstation>"
    exit 1
fi

echo "Installing in $MODE mode..."

# Get current directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Detect OS
OS=$(uname -s)

# Link dotfiles
ln -sf $SCRIPT_DIR/.bashrc $HOME/.bashrc
ln -sf $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -sf $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -sf $SCRIPT_DIR/.gitexclude $HOME/.gitexclude
ln -sf $SCRIPT_DIR/.screenrc $HOME/.screenrc
ln -sf $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -sfn $SCRIPT_DIR/bin $HOME/bin
mkdir -p $HOME/.config/zed/
ln -sf $SCRIPT_DIR/zed-settings.json $HOME/.config/zed/settings.json
mkdir -p $HOME/.ssh
ln -sf $SCRIPT_DIR/ssh-config $HOME/.ssh/config
if [ -d ~/Sync ]; then
    install -m 600 ~/Sync/Dotfiles/.ssh/id_ecdsa ~/.ssh/id_ecdsa
    install -m 600 ~/Sync/Dotfiles/.ssh/id_ecdsa.pub ~/.ssh/id_ecdsa.pub
fi



# Link workstation-specific dotfiles
if [ "$MODE" = "workstation" ]; then
    ln -sf $SCRIPT_DIR/.gitconfig.workstation $HOME/.gitconfig.workstation

    # Plasma virtual keyboard layout overlay (custom fallback main.qml, with
    # symlinks back to the system layouts so the overlay directory still works)
    PLASMA_LAYOUTS=$HOME/.local/share/plasma/keyboard/layouts
    SYS_PLASMA_LAYOUTS=/usr/share/plasma/keyboard/layouts
    mkdir -p $PLASMA_LAYOUTS/fallback
    ln -sfn $SYS_PLASMA_LAYOUTS/en_GB $PLASMA_LAYOUTS/en_GB
    ln -sfn $SYS_PLASMA_LAYOUTS/en_US $PLASMA_LAYOUTS/en_US
    for f in dialpad.qml digits.qml handwriting.qml numbers.qml symbols.qml; do
        ln -sf $SYS_PLASMA_LAYOUTS/fallback/$f $PLASMA_LAYOUTS/fallback/$f
    done
    ln -sf $SCRIPT_DIR/plasma-keyboard-layouts/main.qml $PLASMA_LAYOUTS/fallback/main.qml
fi

# Package installation (Linux only)
if [ "$OS" = "Linux" ]; then
    # Install common packages on Debian/Ubuntu
    if [ -f "/usr/bin/apt" ]; then
        sudo apt-get update
        sudo apt-get install -y $(cat "$SCRIPT_DIR/packages/ubuntu-server-apt")
    fi

    # Install common packages on Ublue/Bazzite
    if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
        brew install $(cat "$SCRIPT_DIR/packages/bazzite-desktop-homebrew")
        flatpak install --system -y $(cat "$SCRIPT_DIR/packages/bazzite-desktop-flatpak")
    fi

    # Install pyenv and friends (workstation only)
    if [ "$MODE" = "workstation" ]; then
        if [ ! -d $HOME/.pyenv ]; then
            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
            eval "$(pyenv init -)"
        fi
        if [ ! -d $(pyenv root)/plugins/pyenv-virtualenv ]; then
            git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
        fi
    fi
fi
