{ pkgs, lib, ... }:
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

  programs.gh = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        linemode = "size_and_mtime";
      };
    };

    initLua = ''
      function Linemode:size_and_mtime()
        local time = math.floor(self._file.cha.mtime or 0)

        if time == 0 then
          time = ""
        elseif os.date("%Y", time) == os.date("%Y") then
          time = os.date("%b %d %H:%M", time)
        else
          time = os.date("%b %d  %Y", time)
        end

        local size = self._file:size()

        return string.format(
          "%9s %s",
          size and ya.readable_size(size) or "-",
          time
        )
      end
    '';

    plugins = {
      git = {
        package = pkgs.yaziPlugins.git;
        setup = true;

        settings = {
          refresh = false;
          update_after_op = true;
          show_ignored = false;

          debounce = 150;
          max_depth = 8;

          symbols = {
            added = "A";
            modified = "M";
            deleted = "D";
            renamed = "R";
            copied = "C";
            typechanged = "T";
            unmerged = "U";
            untracked = "";
            ignored = "I";
            external = "";
            clean = "";
          };

          colors = {
            added = "green";
            modified = "yellow";
            deleted = "red";
            renamed = "cyan";
            copied = "green";
            typechanged = "magenta";
            unmerged = "red";
            untracked = "blue";
            ignored = "brightblack";
            external = "cyan";
          };
        };
      };

      full-border = {
        package = pkgs.yaziPlugins.full-border;
        setup = true;

        settings = {
          type = lib.generators.mkLuaInline "ui.Border.ROUNDED";
        };
      };

      # Hide the status line entirely.
      no-status = {
        package = pkgs.yaziPlugins.no-status;
        setup = true;
      };

      # Functional plugins don't require setup().
      jump-to-char.package = pkgs.yaziPlugins.jump-to-char;
      smart-enter.package = pkgs.yaziPlugins.smart-enter;
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "f";
          run = "plugin jump-to-char";
          desc = "Jump to file by first character";
        }

        {
          on = "l";
          run = "plugin smart-enter";
          desc = "Enter directory or open file";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    lazygit
    ripgrep
    fd
    fzf
    tig
    htop
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
    kdePackages.kdeconnect-kde # kde-connect
    webcamoid # webcam
    ffmpeg # GIF and videos
    wtype
  ];

}
