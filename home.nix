{ pkgs-unstable, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "vanshaj";
  home.homeDirectory = "/home/vanshaj";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs-unstable; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    nodejs
    jdk17 # jdk
    # cargo # rust package manager
    luajit
    # python3

    lazygit
    qbittorrent
    vlc
    # kdePackages.kdeconnect-kde
    # kdePackages.plasma-browser-integration
    # google-chrome
    # tree-sitter

    zoxide # better cd command
    fastfetch
    #neofetch
    #nnn # terminal file manager

    # hyprland
    # waybar
    # wofi

    # archives
    #zip
    #xz
    #p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fd # search files
    #jq # A lightweight and flexible command-line JSON processor
    #yq-go # yaml processor https://github.com/mikefarah/yq
    #eza # A modern replacement for ‘ls’
    #fzf # A command-line fuzzy finder

    # networking tools
    #mtr # A network diagnostic tool
    #iperf3
    #dnsutils  # `dig` + `nslookup`
    #ldns # replacement of `dig`, it provide the command `drill`
    #aria2 # A lightweight multi-protocol & multi-source command-line download utility
    #socat # replacement of openbsd-netcat
    #nmap # A utility for network discovery and security auditing
    #ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    #cowsay
    file
    #which
    tree
    tig
    # grimblast
    gnumake
    #gnused
    #gnutar
    #gawk
    #zstd
    #gnupg

    # nix related
    # nix-tree
    # it provides the command `nom` works just like `nix`
    # with more details log output
    #nix-output-monitor

    # productivity
    #hugo # static site generator
    #glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    #iotop # io monitoring
    #iftop # network monitoring

    # system call monitoring
    #strace # system call monitoring
    #ltrace # library call monitoring
    #lsof # list open files

    # system tools
    #sysstat
    #lm_sensors # for `sensors` command
    #ethtool
    #pciutils # lspci
    #usbutils # lsusb
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Vanshaj Saxena";
    userEmail = "vs110405@outlook.com";
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
    icons = true;
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
      nix-show-usage = "nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "colored-man-pages" "zoxide" ];
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

  set -g default-terminal "screen-256color"
  set -ga terminal-overrides ",*256col*:Tc"
  set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
  set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
  # 30% v-split 
  bind-key E split-window -h -l 38% -c "#{pane_current_path}"
  bind-key R run-shell 'tmux neww'

  bind-key c new-window -c "#{pane_current_path}"

  bind-key A split-window -v -c "#{pane_current_path}"
  bind-key a split-window -h -c "#{pane_current_path}"

  bind-key b break-pane -P -d
  bind-key v copy-mode -e -u

  set -g automatic-rename on
  set -g renumber-windows on
  bind -r g display-popup -d '#{pane_current_path}' -w80% -h80% -E lazygit
  bind -r b display-popup -d '#{pane_current_path}' -w80% -h80% -E btop
  bind -r h display-popup -d '#{pane_current_path}' -w80% -h80% -E htop
  bind -r r display-popup -d '#{pane_current_path}' -w80% -h80% -E ranger
  bind -r > display-popup -d '#{pane_current_path}' -w80% -h80% -E 
  bind -r e kill-pane -a

  # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
  run '~/.tmux/plugins/tpm/tpm'
  '';
  plugins = with pkgs-unstable; [ tmuxPlugins.cpu
  {
   plugin = tmuxPlugins.vim-tmux-navigator;
  }
  ];
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    theme = "Gruvbox Dark Hard";
    keybindings = {
      "ctrl+shift+/" = "launch --location=hsplit";
      "ctrl+shift+\\" = "launch --location=vsplit";
      "ctrl+q" = "close";
    };
    extraConfig = ''
      background #141617
      term xterm-256color
    '';
    settings = {
      background_opacity = "0.90";
      hide_window_decorations = "yes";
      enable_layouts = "splits";
      cursor_shape = "block";
      cursor_blink_interval = 0;
      scrollback_lines = 2000;
      dynamic_background_opacity = "yes";
      confirm_os_window_close = 0;
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  # starship - an customizable prompt for any shell
  # programs.starship = {
  #   enable = true;
  #   # custom settings
  #   settings = {
  #     add_newline = false;
  #     aws.disabled = true;
  #     gcloud.disabled = true;
  #     line_break.disabled = true;
  #   };
  # };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  # programs.alacritty = {
  #   enable = true;
  #   # custom settings
  #   settings = {
  #     env.TERM = "xterm-256color";
  #     font = {
  #       size = 12;
  #       draw_bold_text_with_bright_colors = true;
  #     };
  #     scrolling.multiplier = 5;
  #     selection.save_to_clipboard = true;
  #   };
  # };

  # programs.bash = {
  #   enable = true;
  #   enableCompletion = true;
  #   # TODO add your custom bashrc here
  #   bashrcExtra = ''
  #     export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
  #   '';

  #   # set some aliases, feel free to add more or remove some
  #   shellAliases = {
  #     k = "kubectl";
  #     urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
  #     urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  #   };
  # };

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
