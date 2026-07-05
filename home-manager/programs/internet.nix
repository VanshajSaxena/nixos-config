{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromium
    qbittorrent # torrent client
    discord # voice, text and video chat
    tor-browser # tor network browser
    neovim
    neovide # neovim GUI
  ];
}
