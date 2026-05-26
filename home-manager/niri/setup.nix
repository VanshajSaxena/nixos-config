{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    xwayland-satellite
    waybar
    pamixer # waybar audio scroll
    pavucontrol # waybar audio control
    mako
    awww
    brightnessctl
    wireplumber
    playerctl
    networkmanagerapplet
  ];

}
