{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    xwayland-satellite
    waybar
    fuzzel
    mako
    swww
    brightnessctl
    wireplumber
    playerctl
  ];

}
