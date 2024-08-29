#!/bin/bash

echo "Starting the devbox setup. Installing Nix package manager"

# Install Nix in single-user mode
curl -L https://nixos.org/nix/install | sh

# Source Nix environment
. ~/.nix-profile/etc/profile.d/nix.sh

# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf

echo "Installing Home Manager"

# Setup Home Manager Nix config
mkdir -p ~/.config/home-manager
cp ./nixpkgs/flake.nix ~/.config/home-manager/flake.nix
cp ./nixpkgs/home.nix ~/.config/home-manager/home.nix

nix shell github:nix-community/home-manager#home-manager -c home-manager switch --flake ~/.config/home-manager

# Install Home Manager permanently
nix profile install nixpkgs#home-manager

# Source Nix profile again to ensure Home Manager is in PATH
. ~/.nix-profile/etc/profile.d/nix.sh

# Add Nix profile binaries to PATH for future sessions
echo 'export PATH=$HOME/.nix-profile/bin:$PATH' >>~/.bashrc

# Reload your shell configuration for the current session
. ~/.bashrc

# Check Home Manager and Nix versions
home-manager --version
nix --version
nix-env --version
nix-shell --version

echo "Nix packages installed. Now configuring dot files..."

cp -r ./dotfiles ~/.dotfiles

stow nvim
stow zsh
stow zellij
stow alacritty

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo usermod -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle <~/.zsh_plugins.txt >~/.zsh_plugins.sh

# install apps that are not in nix package manager
echo "Dotfiles configured. Downloading other packages..."

# Zed
curl https://zed.dev/install.sh | sh

echo "Install neovim plugins"
nvim --headless +PlugInstall +qall

echo "Setup Complete!! Yay! Happy Coding!🎇💻"
