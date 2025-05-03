{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 12; # 12 being normal
    themeFile = "gruvbox-dark-hard";
    keybindings = {
      "ctrl+shift+/" = "launch --location=hsplit";
      "ctrl+shift+\\" = "launch --location=vsplit";
    };
    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
      # https://github.com/tonsky/FiraCode?tab=readme-ov-file#whats-in-the-box
      font_features FiraCodeNF-Reg +zero +ss03 +ss04 +ss10 +cv16 +cv30
      font_features FiraCodeNF-SemBd +zero +ss03 +ss04 +ss10 +cv16 +cv30
      font_features FiraCodeNF-Ret +zero +ss03 +ss04 +ss10 +cv16 +cv30
      background #141617
      # term xterm-256color # don't set the term variable
      include ./font.conf
    '';
    settings = {
      background_opacity = "0.70";
      hide_window_decorations = "yes";
      enabled_layouts = "splits";
      cursor_shape = "block";
      cursor_blink_interval = 0;
      scrollback_lines = 10000;
      dynamic_background_opacity = "yes";
      cursor_trail = 1;
      cursor_trail_decay = "0.05 0.20";
      cursor_trail_start_threshold = 1;
      confirm_os_window_close = 0;
    };
  };
}
