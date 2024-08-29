{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];

  home.username = "puran";
  home.homeDirectory = "/home/puran";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    alacritty
    kitty
    go
  ];

}
