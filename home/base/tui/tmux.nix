{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    baseIndex = 1;
    historyLimit = 50000;
    escapeTime = 0;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g renumber-windows on
      bind  c  new-window      -c "#{pane_current_path}"
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      # Required for image.nvim
      set -gq allow-passthrough on
      set -g visual-activity off
    '';
    shell = "${pkgs.fish}/bin/fish";
    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      fzf-tmux-url
      vim-tmux-navigator
    ];
  };

  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"
    set -g status-right-length 100
    set -g status-left-length 100
    set -g status-left ""
    set -g status-right "#{E:@catppuccin_status_application}"
    set -ag status-right "#{E:@catppuccin_status_session}"
  '';

  # Auto start tmux on fish interactive shell
  programs.fish.interactiveShellInit = ''
    if not set -q TMUX
        exec ${pkgs.tmux}/bin/tmux new-session -A -s main
    end
  '';
}
