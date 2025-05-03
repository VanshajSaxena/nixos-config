{ pkgs, ... }:
{
  imports = [
    ./application.nix
    ./networking.nix
    ./development.nix
    ./terminal.nix
    ./tools.nix
    ./utils.nix
  ];
}
