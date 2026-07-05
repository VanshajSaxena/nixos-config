{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc # media player
  ];
}
