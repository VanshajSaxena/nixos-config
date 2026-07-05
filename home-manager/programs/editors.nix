{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gimp3-with-plugins # edit photos
    pinta # paint program
  ];
}
