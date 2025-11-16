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
    xwayland-satellite
    waybar
    fuzzel
    mako
    swww

    brightnessctl
    wireplumber
    playerctl

  ];

  services = {
    polkit-gnome = {
      enable = true;
    };
  };

  # https://yalter.github.io/niri/Important-Software.html#portals
  services.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

}
