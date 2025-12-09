#!/bin/bash

apt update && apt install -y sudo

# Check if the script is running as root (EUID = 0)
# This applies for when testing in a Docker container
if [ $EUID -eq 0 ]; then
    echo "Started as root, creating user"

    sudo useradd -m jackson # -m creates the home directory

    echo "[!] Setting user password:"
    passwd jackson

    sudo usermod -aG sudo jackson

    echo "Rerun script from jackson shell."
    su - jackson
fi

if ! command -v git &>/dev/null; then
    sudo apt -y install git
fi

if [ ! -d $HOME/personal ]; then
    mkdir $HOME/personal
fi

git clone https://github.com/jacksonbarr1/dev $HOME/personal/dev

cd $HOME/personal/dev
chmod +x run.sh
export DEV_ENV=$(pwd)
echo "Initialization completed, running scripts..."
./run.sh
