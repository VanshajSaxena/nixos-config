{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      lz = "lazygit";
      nf = "fastfetch";
      cat = "bat";
      ll = "l";
      lt = "exa --tree --ignore-glob '.git'";
      lT = "ll --tree --ignore-glob '.git'";
      nix-show-usage = "nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree";
      leet = "nvim leetcode.nvim";
      leetvide = "neovide -- leetcode.nvim";
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
        "mvn"
      ];
      theme = "gentoo";
      extraConfig = ''
        # this function helps me to attach to an existing tmux session
        # if [ -z "$TMUX" ]; then
        #   attach_session=$(tmux 2> /dev/null ls -F \
        #     '#{session_attached} #{?#{==:#{session_last_attached},},1,#{session_last_attached}} #{session_id}' |
        #     awk '/^0/ { if ($2 > t) { t = $2; s = $3 } }; END { if (s) printf "%s", s }')
        #   if [ -n "$attach_session" ]; then
        #     tmux attach -t "$attach_session"
        #   else
        #     tmux
        #   fi
        # fi
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
    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
    ];
  };

  home.packages = with pkgs; [
    fastfetch # neofetch successor
    zoxide
  ];
}
