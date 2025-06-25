{ pkgs, ... }:
{
  programs.sioyek = {
    enable = true;
    bindings = {
      "screen_down" = [
        "d"
        "<C-d>"
      ];
      "screen_up" = [
        "u"
        "<C-u>"
      ];
      "move_left" = "{";
      "move_right" = "}";
    };
    config = {
      "toggle_two_page_mode" = "<f2>";
      "startup_commands" = "toggle_dark_mode;toggle_mouse_drag_mode";
      "wheel_zoom_on_cursor" = "1";
    };
  };

  home.packages = with pkgs; [
    hugo # static site engine
    kdePackages.kdeconnect-kde # kde-connect
    webcamoid # webcam
    obs-studio
    #   kdePackages.kcalc # calculator
  ];
}
