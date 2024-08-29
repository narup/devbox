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
    vscode
    brave
    fx # terminal JSON viewer
    ncdu
    jq
    yarn
    htop
    docker
    flameshot # for screenshot
    localsend # Airdrop alternative 
    ollama
    redis
  ];

}
