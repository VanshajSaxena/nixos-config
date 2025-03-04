{ pkgs-unstable, zen-browser, ... }:

{
  home.username = "vanshaj";
  home.homeDirectory = "/home/vanshaj";

  home.packages = with pkgs-unstable; [
    nodejs # copilot server
    jdk # java development kit
    gradle # java build system
    cargo # rust package manager
    lua51Packages.lua # lua_5.1
    luajitPackages.luarocks # lua package manager
    # kdePackages.umbrello # UML GUI # now broken
    ghc # glasgo haskell compiler
    haskell-language-server # haskell LSP
    python3
    kdePackages.merkuro # calender
    kdePackages.kdeconnect-kde # kde-connect
    kdePackages.kcalc # calculator
    thunderbird
    # kdePackages.neochat # matrix client by KDE
    gimp # edit photos
    ffmpeg_7 # gif and videos
    hugo # static site engine
    lazygit # git TUI
    qbittorrent # torrent client
    discord # voice, text and video chat
    networkmanagerapplet # nm-applet
    xdotool # x11 automation tool
    tor-browser # tor network browser
    vlc # media player
    tree-sitter # syntax highlighter
    pinta # paint program
    zoxide # better cd command
    fastfetch # neofetch successor
    webcamoid # webcam
    neovide # neovim GUI
    ripgrep # better grep command
    fd # better find command
    fzf # fuzzy finder
    chafa # terminal graphics
    # ueberzugpp # terminal graphics # probably requires configuration dosn't work oftb.
    # viu # teminal graphics
    # ghostty
    file
    # krusader # split file manager
    yazi # terminal file manager
    tree # show directory tree
    tig # git TUI
    gnumake # idr why its here, I needed it for some program to compile
    nix-tree # interactive browse dependency graphs of nix derivations
    nixd # nix LSP
    nixfmt-rfc-style # official nix formatter
    nix-output-monitor

    btop # replacement of htop/nmon
    dust # du alternative
    hyperfine # benchmarking tool

    dig # dns lookup
    whois
    ollama
    wineWowPackages.waylandFull # wine for windows programs
    samba4Full
    ghostscript # postscript interpreter (pdf previews)
    tectonic-unwrapped # modern Tex engine

    zen-browser.packages."x86_64-linux".twilight # artifacts are downloaded from this repository to guarantee reproducibility
  ];

  # basic configuration of git
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

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "always";
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

  programs.zsh = {
    enable = true;
    shellAliases = {
      lz = "lazygit";
      nf = "fastfetch";
      cat = "bat";
      lt = "ll --tree --ignore-glob '.git'";
      ll = "l";
      nix-show-usage = "nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree";
      leet = "nvim leetcode.nvim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
        "zoxide"
        "ssh-agent"
        "kitty"
        "fzf"
        "gradle"
      ];
      theme = "simple";
      extraConfig = ''
        # this function helps me to attach to an existing tmux session
        if [ -z "$TMUX" ]; then
          attach_session=$(tmux 2> /dev/null ls -F \
            '#{session_attached} #{?#{==:#{session_last_attached},},1,#{session_last_attached}} #{session_id}' |
            awk '/^0/ { if ($2 > t) { t = $2; s = $3 } }; END { if (s) printf "%s", s }')
          if [ -n "$attach_session" ]; then
            tmux attach -t "$attach_session"
          else
            tmux
          fi
        fi
      '';
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 10;
    focusEvents = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-a";
    historyLimit = 10000;
    extraConfig = ''
      # Install tpm:
      # git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'lawabidingcactus/tmux-gruvbox-truecolor'

      set -g repeat-time 800

      # vi-movements within tmux panes
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # resize pane 
      bind-key -r -T prefix C-h resize-pane -L
      bind-key -r -T prefix C-j resize-pane -D
      bind-key -r -T prefix C-k resize-pane -U
      bind-key -r -T prefix C-l resize-pane -R

      set -g default-terminal 'tmux-256color'
      set -ga terminal-overrides ',*256col*:Tc'
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
      # 30% v-split 
      bind-key E split-window -h -l 38% -c '#{pane_current_path}'
      bind-key R run-shell 'tmux neww'

      bind-key c new-window -c '#{pane_current_path}'

      bind-key A split-window -v -c '#{pane_current_path}'
      bind-key a split-window -h -c '#{pane_current_path}'

      bind-key b break-pane -P -d
      bind-key v copy-mode
      # Use wl-copy for clipboard integration
      bind-key -T copy-mode-vi y send-keys -X copy-pipe 'wl-copy'

      set -g automatic-rename on
      set -g renumber-windows on
      bind-key -r g display-popup -d '#{pane_current_path}' -w80% -h80% -EB lazygit
      bind-key -r b display-popup -d '#{pane_current_path}' -w80% -h80% -EB btop
      bind-key -r h display-popup -d '#{pane_current_path}' -w80% -h80% -EB htop
      bind-key -r y display-popup -d '#{pane_current_path}' -w80% -h80% -EB yazi
      bind-key -r > display-popup -d '#{pane_current_path}' -w80% -h80% -EB
      bind-key -r e kill-pane -a

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
    '';
    plugins = with pkgs-unstable; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
    ];
  };

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
    };
  };

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
      cursor_trail_decay = "0.15 0.45";
      cursor_trail_start_threshold = 1;
      confirm_os_window_close = 0;
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
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
