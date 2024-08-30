#!/bin/bash

echo "Starting the devbox setup"

# Enable flakes
mkdir -p ~/.config/nix

echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf

echo "Installing Home Manager"

# Setup Home Manager Nix config directory and copy the already packaged nix files 
mkdir -p ~/.config/home-manager
cp ./nix/flake.nix ~/.config/home-manager/flake.nix
cp ./nix/home.nix ~/.config/home-manager/home.nix

#install the packages defined in home.nix
home-manager switch --flake ~/.config/home-manager

echo "Nix packages installed. Now configuring dot files..."

cp -r ./dotfiles ~/.dotfiles

cd ~/.dotfiles

stow nvim
stow zellij
stow alacritty
stow kitty 

cd ..
echo "🎇💻Setup Complete!! Reboot the system once just to make sure things are loaded. Yay!! Happy Coding!🎇💻"
