{
  pkgs,
  lib,
  ...
}: let
  vim-tmux-navigation =
    pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "vim-tmux-navigation";
      version = "2024-12-06";
      src = pkgs.fetchFromGitHub {
        owner = "christoomey";
        repo = "vim-tmux-navigator";
        rev = "d847ea942a5bb4d4fab6efebc9f30d787fd96e65";
        sha256 = "EkuAlK7RSmyrRk3RKhyuhqKtrrEVJkkuOIPmzLHw2/0=";
      };
      rtpFilePath = "vim-tmux-navigator.tmux";
    };
in {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    baseIndex = 1;
    historyLimit = 50000;
    escapeTime = 0;
    terminal = "tmux-256color";
    plugins = [
      {
        plugin = vim-tmux-navigation;
      }
    ] ++ (with pkgs.tmuxPlugins; [
        {
          plugin = cpu;
          extraConfig = ''
            set -agF status-right "#{E:@catppuccin_status_cpu}"
          '';
        }
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
    ]);
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
