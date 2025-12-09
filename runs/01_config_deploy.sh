#!/usr/bin/env bash
echo "--- 02: Deploying Configurations via Bare Git Repo"

DOTFILES_REPO="https://github.com/jacksonbarr1/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_CMD="config"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning bare dotfiles repo from $DOTFILES_REPO..."
    git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "Bare dotfiles repo already exists."
fi

echo >"alias $CONFIG_CMD='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >>"$HOME/.bashrc"
source "$HOME/.bashrc"

echo "Deploying configurations to $HOME"

$CONFIG_CMD config status.showUntrackedFiles no

$CONFIG_CMD checkout -f

echo "Dotfiles successfully deployed."
