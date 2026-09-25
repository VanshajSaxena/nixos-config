{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio # screen recording via the niri PipeWire portal
    vlc # media player
  ];
}
