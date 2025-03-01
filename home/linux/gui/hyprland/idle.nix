{wallpapers, ...}: {
  programs.hyprlock = {
    enable = true;
    # https://github.com/justinmdickey/publicdots/blob/main/.config/hypr/hyprlock.conf
    settings = {
      background = {
        path = "${wallpapers}/by_burned_2560.jpg";
        blur_passes = 2;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };
      general = {
        grace = 0;
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        disable_loading_bar = true;
      };
      input-field = [
        {
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "#cdd6f4";
          fade_on_empty = false;
          rounding = -1;
          check_color = "rgb(204, 136, 34)";
          placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
          hide_input = false;
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        {
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "JetBrainsMono Nerd Font Bold";
          position = "0, 50";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 5 * 60; # 5min
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 6 * 60; # 6min
          on-timeout = "hyprlock";
        }
      ];
    };
  };
}
