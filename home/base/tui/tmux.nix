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
    extraConfig = ''
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on

      unbind C-b
      set -g prefix C-a

      set -g history-limit 102400
    '';
    plugins = [
      {
        plugin = vim-tmux-navigation;
      }
    ];
  };
}
