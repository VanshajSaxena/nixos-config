{ pkgs, ... }:
{

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = false;
      search_files_in_root = true;
      favicon_service = "twenty";

      font = {
        normal = {
          size = 11;
          family = "Maple Mono NF";
        };
      };

      theme = {
        light = {
          name = "vicinae-light";
          icon_theme = "default";
        };
        dark = {
          name = "vicinae-dark";
          icon_theme = "default";
        };
      };

      launcher_window = {
        opacity = 0.98;
      };
    };
  };

  home.packages = with pkgs; [
    kdePackages.kcalc
    hugo
  ];
}
