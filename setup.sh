#!/bin/bash

echo "Starting the devbox setup"

# Setup Home Manager Nix config directory and copy the already packaged nix files 
mkdir -p ~/.config/home-manager
cp ./nix/flake.nix ~/.config/home-manager/flake.nix
cp ./nix/home.nix ~/.config/home-manager/home.nix

nix-shell -p home-manager 

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
