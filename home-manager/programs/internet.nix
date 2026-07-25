{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qbittorrent # torrent client
    discord # voice, text and video chat
    tor-browser # tor network browser
    neovim
    neovide # neovim GUI
  ];

  programs.chromium = {
    enable = true;
    commandLineArgs = [ "--enable-features=MiddleClickAutoscroll" ];
  };
}
