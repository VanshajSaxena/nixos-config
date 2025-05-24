{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xdg-desktop-portal-gtk # Hyprland file picker exception
    brightnessctl
    playerctl
  ];

  programs.waybar = {
    enable = true;
  };
}
