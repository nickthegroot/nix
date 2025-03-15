{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # conflicts with uwsm

    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 4;
        "col.active_border" = "0xFFB4A1DB";
        "col.inactive_border" = "0xFF343A40";
      };

      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          ignore_opacity = false;
        };
      };

      animations = {
        enabled = 1;
        # NAME,ONOFF,SPEED,CURVE,STYLE
        animation = [
          "windows,1,8,default,popin 80%"
          "fadeOut,1,8,default"
          "fadeIn,1,8,default"
          "workspaces,1,8,default"
        ];
      };
    };
  };

  # Hint Electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
