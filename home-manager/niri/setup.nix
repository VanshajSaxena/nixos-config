{
  pkgs,
  ...
}:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  home.packages = with pkgs; [
    waybar
    fuzzel
    mako
    swww
    xwayland-satellite
    brightnessctl
    wireplumber
    playerctl
  ];
}
