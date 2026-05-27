{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Vanshaj Saxena";
        email = "vs110405@outlook.com";
      };
      init = {
        defaultBranch = "master";
      };
      pull = {
        ff = "only";
      };
      diff = {
        tool = "vimdiff";
      };
    };
    signing.format = null;
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "always";
  };

  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
      theme = "Dracula";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "onedark";
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
    tig
    htop
    yazi
    xdotool # X11 automation tool
    dust # du alternative
    scc # code counter
    hyperfine # benchmarking tool
    tectonic
    ghostscript
    wev # wayland event viewer
    imagemagick
    charm-freeze
    silicon
    # ffmpeg_7 # GIF and videos
  ];

}
