{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dig # DNS lookup
    inetutils
    httpie # HTTP CLI tool that's human friendly
  ];

  services.network-manager-applet = {
    enable = true;
  };
}
