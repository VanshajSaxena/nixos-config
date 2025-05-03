{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dig # DNS lookup
    inetutils
    httpie # HTTP CLI tool that's human friendly
    networkmanagerapplet # NM-applet
  ];
}
