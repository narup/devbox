{ config, pkgs, ... }:
{
  home.username = "puran";
  home.homeDirectory = "/home/puran";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    gcc
    binutils
    make
    glibc
    gnumake 
    binutils 
    coreutils
    g++
    neovim
    git
    zsh
	  antibody
	  stow
	  fzf
    yazi
	  ripgrep
	  bat
	  gnumake
    btop
    neofetch
    bun
	  direnv
    alacritty
    zellij
    tableplus
    wireguard-tools
    go
    rbenv
    ruby
    elixir
    asdf-vm
    rustup
    nasm
    zig
    postgresql_16
    mongodb
    mongodb-compass
    vscode
    brave
    fx # terminal JSON viewer
    ncdu
    jq
    yarn
    htop
    docker
    corretto17 # Amazon distribution of Open JDK 17
    flameshot # for screenshot
    localsend # Airdrop alternative 
    ollama
    redis
  ];

  programs.zsh = {
    enable = true;
    # Add your zsh configuration here
  };

  programs.neovim = {
    enable = true;
    # Add your neovim configuration here
  };

  # Add more program configurations as needed
}
