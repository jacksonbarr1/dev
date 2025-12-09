#!/usr/bin/env bash

NEOVIM_TAG="stable"
INSTALL_DIR="/usr/local/bin/nvim"
SOURCE_DIR="$HOME/src/neovim"

if [ -f "$INSTALL_DIR" ]; then
    echo "Neovim binary found at $INSTALL_DIR. Skipping compilation..."
    # TODO: Version check
else
    echo "Neovim not found. Proceeding with installation."

    echo "Installing required build dependencies..."
    sudo apt install -y curl wget build-essential cmake gettext libtool libtool-bin

    echo "Cloning and checkout out tag $NEOVIM_TAG..."
    mkdir -p "$HOME/src"

    if [ ! -d "$SOURCE_DIR" ]; then
        git clone https://github.com/neovim/neovim.git "$SOURCE_DIR"
    fi

    cd "$SOURCE_DIR"
    git fetch --tags
    git checkout "$NEOVIM_TAG"

    echo "Compiling Neovim..."
    rm -rf build

    make CMAKE_BUILD_TYPE=RelWithDebInfo || {
        echo "Compilation failed. Exiting."
        exit1
    }

    echo "Installing to $INSTALL_DIR..."
    sudo make install
fi

if [ -f "$INSTALL_DIR" ]; then
    echo "Neovim successfully installed:"
    $INSTALL_DIR --version | head -n 1
else
    echo "Neovim installation failed."
    exit 1
fi
