{
  # Note: should be kept in sync with home/linux/gui/hyprland/conf/hyprland.conf
  
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      mouse_follows_focus = "on";
      window_placement = "second_child";
      window_topmost = "off";
      window_opacity = "on";
      window_border = "off";
      window_shadow = "on";
      active_window_border_color = "0xff008bff";
      normal_window_border_color = "0x01000000";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.94" ;
      split_ratio = "0.50";
      auto_balance = "off";
      window_animation_duration = "0.0";

      # general space settings
      layout = "bsp";
      top_padding = "5";
      bottom_padding = "5";
      left_padding = "5";
      right_padding = "5";
      window_gap = "10";
      external_bar = "all:32:0";
    };
    
    extraConfig = ''
      # Required until https://github.com/LnL7/nix-darwin/issues/1224 is resolved
      yabai -m signal --add event=dock_did_restart action='sudo yabai --load-sa'
      sudo yabai --load-sa
    '';
  };

  services.jankyborders = {
    enable = true;
    
    width = 8.0;
    active_color = "0xFFB4A1DB";
    inactive_color = "0xFF343A40";
  };
}
