#!/usr/bin/env bash

echo "Removing existing neovim installation and configuration..."
sudo rm -rf $HOME/personal/src/neovim
sudo rm -rf $HOME/.config/nvim
sudo rm -rf $HOME/.local/share/nvim
sudo rm -rf $HOME/.local/state/nvim
sudo rm -rf /usr/local/bin/nvim
sudo rm -rf /usr/local/share/nvim

echo "Cloning neovim (stable)..."
git clone --depth 1 --branch stable https://github.com/neovim/neovim.git $HOME/personal/src

pushd $HOME/personal/src/neovim
echo "Building neovim from source..."

rm -r build/ # clear CMake cache
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install
export PATH="$HOME/neovim/bin:$PATH"
