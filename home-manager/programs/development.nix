{ pkgs, ... }:
{
  home.packages = with pkgs; [

    #Nix
    direnv
    nix-direnv

    # Node
    nodejs
    yarn

    # Java
    jdk # java development kit
    gradle # java build system
    maven # java build system

    # Rust
    cargo # rust package manager

    # API
    postman # API Development Environment
    openapi-generator-cli # generate API client/server code

    # Lua
    lua51Packages.lua
    luajitPackages.luarocks

    # Haskell
    # ghc # Glasgow Haskell Compiler

    #Python
    python3
    uv

    # Nix
    nixfmt-rfc-style # official nix formatter
    nixd # nix LSP

    # Docs
    mermaid-cli # mermaid diagrams

    # Lib
    icu # Unicode and globalization support library # marksman-lsp
  ];
}
