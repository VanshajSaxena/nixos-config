{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunderbird
    gimp # edit photos
    qbittorrent # torrent client
    discord # voice, text and video chat
    tor-browser # tor network browser
    vlc # media player
    pinta # paint program
    neovide # neovim GUI
    # haskell-language-server # haskell LSP
    # kdePackages.merkuro # calender
    #   kdePackages.kcalc # calculator
    #   # kdePackages.neochat # matrix client by KDE
    #   tree-sitter # syntax highlighter
    #   file
    #   # krusader # split file manager
    #   tree # show directory tree
    #   gnumake # idr why its here, I needed it for some program to compile
    #   nix-tree # interactive browse dependency graphs of nix derivations
    #   nix-output-monitor
    #   openssl # cryptographic library that implements the SSL and TLS protocols
    #
    #
    #   wineWowPackages.waylandFull # wine for windows programs
    #   samba4Full
    #   ghostscript # postscript interpreter (pdf previews)
    #   icu # unicode and globalization support library
    #
  ];
}
