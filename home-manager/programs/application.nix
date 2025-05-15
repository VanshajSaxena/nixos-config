{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunderbird
    gimp3-with-plugins # edit photos
    qbittorrent # torrent client
    discord # voice, text and video chat
    tor-browser # tor network browser
    vlc # media player
    pinta # paint program
    neovide # neovim GUI
  ];
}
