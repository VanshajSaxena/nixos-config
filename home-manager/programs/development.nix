{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Node
    nodejs # copilot server

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
    ghc

    #Python
    python3

    # Nix
    nixfmt-rfc-style # official nix formatter
    nixd # nix LSP

    # Docs
    mermaid-cli # mermaid diagrams
  ];
}
