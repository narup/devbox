#!/bin/bash

echo "Starting the devbox setup"

# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf

echo "Installing Home Manager"

# Setup Home Manager Nix config
mkdir -p ~/.config/home-manager
cp ./nixpkgs/flake.nix ~/.config/home-manager/flake.nix
cp ./nixpkgs/home.nix ~/.config/home-manager/home.nix

#install home manager permanently
nix-env -iA nixos.home-manager

#install the packages defined in home.nix
home-manager switch --flake ~/.config/home-manager

echo "Nix packages installed. Now configuring dot files..."

cp -r ./dotfiles ~/.dotfiles

cd ~/.dotfiles

stow nvim
stow zellij
stow alacritty

echo "Setup Complete!! Yay! Happy Coding!🎇💻"
