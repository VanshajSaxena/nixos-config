{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dig # dns lookup
    inetutils
    httpie # HTTP cli tool thats human friendly
    networkmanagerapplet # nm-applet
  ];
}
