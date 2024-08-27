#!/bin/bash

echo "Starting the devbox setup. Installing Nix package manager"

# Install Nix in single user mode. For VM, it should be okay to use single user mode
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Source nix
. ~/.nix-profile/etc/profile.d/nix.sh

echo "Nix installation complete. Now install packages..."

# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf

cd ~/nixpkgs

# Build and activate  #homeConfigurations.puran.activationPackage
nix build .
./result/activate

echo "Nix packages installed. Now configuring dot files..."

# exit out of the pkgs directory and cd to dotfiles and run the script
cd ../dotfiles

sh install.sh

# install apps that are not in nix package manager
echo "Dotfiles configured. Downloading other packages..."

# Zed
curl https://zed.dev/install.sh | sh

echo "Setup Complete!! Yay! Happy Coding!🎇💻"
