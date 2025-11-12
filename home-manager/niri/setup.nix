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
    # https://yalter.github.io/niri/Important-Software.html#portals
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring

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
