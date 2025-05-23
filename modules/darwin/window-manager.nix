{ pkgs-stable, ... }:
{
  services.yabai = {
    enable = true;
    package = pkgs-stable.yabai;
    enableScriptingAddition = false;
    config = {
      mouse_follows_focus = "on";
      window_placement = "second_child";
      window_shadow = "float";
      active_window_opacity = 1.0;
      normal_window_opacity = 0.9;
      split_ratio = 0.5;
      auto_balance = "off";

      # Animation
      # window_animation_duration = 0.2;
      # window_animation_easing = "ease_out_quint";
      # window_opacity_duration = 0.2;

      # Opacity
      window_opacity = "on";

      # general space settings
      layout = "bsp";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
      external_bar = "all:30:0";
    };

    extraConfig = ''
      # Required until https://github.com/LnL7/nix-darwin/issues/1224 is resolved
      # yabai -m signal --add event=dock_did_restart action='sudo yabai --load-sa'
      # sudo yabai --load-sa

      # https://github.com/qutebrowser/qutebrowser/issues/4067
      yabai -m rule --add app="^qutebrowser$" title!="^$" role="AXWindow" subrole="AXDialog" manage=on
    '';
  };

  services.jankyborders = {
    enable = true;

    width = 8.0;
    active_color = "0xFFB4A1DB";
    inactive_color = "0xFF343A40";

    blacklist = [
      "Loom"
    ];
  };
}
