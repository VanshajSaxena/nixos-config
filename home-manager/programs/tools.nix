{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Vanshaj Saxena";
    userEmail = "vs110405@outlook.com";
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      diff = {
        tool = "vimdiff";
      };
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "always";
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_material_dark";
      theme_background = false;
      truecolor = true;
      vim_keys = true;
      rounded_corners = true;
      update_ms = 100;
      selected_battery = "BAT1";
    };
  };

  home.packages = with pkgs; [
    lazygit
    ripgrep
    fd
    fzf
    yazi
    xdotool # x11 automation tool
    dust # du alternative
    scc # code counter
    hyperfine # benchmarking tool
    # ffmpeg_7 # gif and videos
  ];

}
