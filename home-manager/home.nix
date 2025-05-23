{
  zen-browser,
  catppuccin,
  enabledHyprland,
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
    ./hyprland
  ];

  home.packages = [
    zen-browser.packages."x86_64-linux".default # browser
  ];

  catppuccin = {
    enable = enabledHyprland;
    mako.enable = false; # temp fix
    nvim.enable = false;
    flavor = "mocha";
  };

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
