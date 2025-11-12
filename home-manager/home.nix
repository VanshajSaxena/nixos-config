{
  zen-browser,
  pkgs,
  inputs,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "vanshaj";
  home.homeDirectory = "/home/vanshaj";
  home.shell.enableZshIntegration = true;

  imports = [
    ./programs
    ./shell
    ./niri
    inputs.niri-flake.homeModules.niri
  ];

  home.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
    config.common.default = "kde";
  };

  home.packages = with pkgs; [
    zen-browser.packages."x86_64-linux".default # browser
    waybar
    fuzzel
    mako
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
