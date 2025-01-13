{
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
      top_padding = "4";
      bottom_padding = "4";
      left_padding = "4";
      right_padding = "4";
      window_gap = "4";
      external_bar = "all:32:0";
    };
  };
}
