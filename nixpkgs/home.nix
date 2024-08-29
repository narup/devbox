{ config, pkgs, ... }:
{
  home.username = "puran";
  home.homeDirectory = "/home/puran";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    neovim
    alacritty
    kitty
    go
  ];

}
