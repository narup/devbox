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
    git
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
    beekeeper-studio
    zsh-powerlevel10k
    open-vm-tools
    meslo-lgs-nf
    fira-code-nerdfont
    cascadia-code
    thefuck 
  ];

  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "powerlevel10k";
    };
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;

    dotDir = ".config/zsh"; #note - it doesn't have to specify home directory

    initExtra = ''
      #Powerlevel10k Zsh theme  
      test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh  
    '';

    # profileExtra = ''
    # export ZDOTDIR="$HOME/.config/zsh"
    #   '';

    sessionVariables = {
      RPS1 = ""; # Disable the right side prompt that "walters" theme introduces
      ZDOTDIR = "~/.config/zsh";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      save = 15000;
      share = true;
    };

    dirHashes = { docs = "$HOME/Documents"; };

    shellAliases = {
      nix-apply = "home-manager switch --flake ~/.config/home-manager/";
      nix-home = "cd ~/.config/home-manager && nvim -n .";
      capi = "cd ~/projects/capi && nvim -n .";
      nix-config = "cd /etc/nixos | sudo nvim -n .";
      vpn-start = "nmcli connection up vpn";
      vpn-stop = "nmcli connection down vpn";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "zsh-abbrev-alias";
        file = "abbrev-alias.plugin.zsh";
        src = builtins.fetchGit {
          # Updated 2020-12-31
          url = "https://github.com/momo-lab/zsh-abbrev-alias";
          rev = "2f3d218f426aff21ac888217b0284a3a1470e274";
        };
      }
      {
        name = "zsh-colored-man-pages";
        file = "colored-man-pages.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/ael-code/zsh-colored-man-pages";
          rev = "57bdda68e52a09075352b18fa3ca21abd31df4cb";
        };
      }
      {
        name = "zsh-fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
  
  programs.home-manager = {
    enable = true;
  };
}
