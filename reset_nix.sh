#!/bin/bash

# Function to print messages
print_message() {
	echo "===> $1"
}

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
	print_message "This script should not be run as root. Please run as a regular user with sudo privileges."
	exit 1
fi

print_message "Starting Nix removal process..."

# Stop Nix daemon if it's running
if pgrep nix-daemon >/dev/null; then
	print_message "Stopping nix-daemon..."
	sudo systemctl stop nix-daemon.socket nix-daemon.service
	sudo systemctl disable nix-daemon.socket nix-daemon.service
fi

# Remove Nix files and directories
print_message "Removing Nix files and directories..."
sudo rm -rf /nix /etc/nix /etc/profile.d/nix.sh ~/.nix-profile ~/.nix-defexpr ~/.nix-channels

# Remove Home Manager configurations
print_message "Removing Home Manager configurations..."
rm -rf ~/.config/nixpkgs ~/.config/home-manager

# Remove Nix profile from shell configuration files
print_message "Removing Nix profile from shell configuration files..."
sed -i '/\.nix-profile/d' ~/.bash_profile ~/.profile ~/.bashrc ~/.zshrc

# Remove Nix-specific environment variables
print_message "Removing Nix-specific environment variables..."
unset NIX_PATH
unset NIX_PROFILES
unset NIX_SSL_CERT_FILE
unset NIX_REMOTE

# Remove Nix from PATH
print_message "Removing Nix from PATH..."
export PATH=$(echo $PATH | sed -e 's/:[^:]*nix[^:]*//g')

# Remove any Nix-related systemd services
print_message "Removing Nix-related systemd services..."
sudo rm -f /etc/systemd/system/nix-daemon.service /etc/systemd/system/nix-daemon.socket
sudo systemctl daemon-reload

# Remove the Nix store
print_message "Removing the Nix store..."
sudo rm -rf /nix/store

# Remove Nix users and groups
print_message "Removing Nix users and groups..."
sudo userdel nixbld1
sudo groupdel nixbld

# Remove any remaining Nix configuration files
print_message "Removing any remaining Nix configuration files..."
sudo rm -f /etc/nix/nix.conf

print_message "Nix removal process complete."
print_message "Please log out and log back in for all changes to take effect."
print_message "You may also want to manually check for and remove any remaining Nix-related entries in your shell configuration files."
