{
  pkgs,
  lib,
  ...
}: {
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
    '';
    plugins = with pkgs.tmuxPlugins; [
        {
          plugin = battery;
          extraConfig = ''
            set -agF status-right "#{E:@catppuccin_status_battery}"
          '';
        }
        {
          plugin = weather;
          # WHAT THE FUCK IS A KILOMETER 🦅
          extraConfig = ''
            set-option -g @tmux-weather-units "u" 
            set -agF status-right "#{E:@catppuccin_status_weather}"
          '';
        }
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
}
