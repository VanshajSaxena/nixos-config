{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs # copilot server
    jdk # java development kit
    gradle # java build system
    maven # java build system
    cargo # rust package manager
    postman # API Development Environment
    openapi-generator-cli # generate API client/server code
    lua51Packages.lua # lua_5.1
    luajitPackages.luarocks # lua package manager
    ghc # glasgo haskell compiler
    python3
    nixfmt-rfc-style # official nix formatter
    nixd # nix LSP
    # haskell-language-server # haskell LSP
    #   libsForQt5.umbrello # UML GUI
    #   kdePackages.merkuro # calender
    #   kdePackages.kdeconnect-kde # kde-connect
    #   kdePackages.kcalc # calculator
    #   thunderbird
    #   # kdePackages.neochat # matrix client by KDE
    #   gimp # edit photos
    #   ffmpeg_7 # gif and videos
    #   hugo # static site engine
    #   qbittorrent # torrent client
    #   discord # voice, text and video chat
    #   networkmanagerapplet # nm-applet
    #   xdotool # x11 automation tool
    #   tor-browser # tor network browser
    #   vlc # media player
    #   tree-sitter # syntax highlighter
    #   pinta # paint program
    #   fastfetch # neofetch successor
    #   webcamoid # webcam
    #   neovide # neovim GUI
    #   chafa # terminal graphics
    #   # ueberzugpp # terminal graphics # probably requires configuration dosn't work oftb.
    #   # viu # teminal graphics
    #   # ghostty
    #   file
    #   # krusader # split file manager
    #   tree # show directory tree
    #   tig # git TUI
    #   gnumake # idr why its here, I needed it for some program to compile
    #   nix-tree # interactive browse dependency graphs of nix derivations
    #   nix-output-monitor
    #   openssl # cryptographic library that implements the SSL and TLS protocols
    #   dust # du alternative
    #   scc # code counter
    #   hyperfine # benchmarking tool
    #
    #   inetutils
    #   ollama
    #   wineWowPackages.waylandFull # wine for windows programs
    #   samba4Full
    #   ghostscript # postscript interpreter (pdf previews)
    #   icu # unicode and globalization support library
    #
  ];
}
