{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "vscode"
  ];


  home.username = "puran";
  home.homeDirectory = "/home/puran";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    gcc
    binutils
    glibc
    gnumake 
    binutils 
    coreutils
    neovim
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
    kitty
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
    oh-my-zsh
    zsh-powerlevel10k
    meslo-lgs-nf
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;  # Optionally, enable Oh My Zsh if you want
    };
  };

  programs.home-manager = {
    enable = true;   
  };
  # You can also add other configurations here...
}
