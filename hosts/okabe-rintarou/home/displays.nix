{
  # BIOS defaults to DP-2 as primary (e.g. grub)
  wayland.windowManager.hyprland = {
    settings = {
      monitorv2 = [
        {
          output = "DP-2";
          mode = "2560x1440@143.91200";
          position = "0x0";
          scale = 1;
        }
        {
          output = "DP-1";
          mode = "1920x1080@144.00101";
          position = "auto-left";
          scale = 1;
          transform = 1;
        }
        {
          output = "HDMI-A-1";
          mode = "2560x1440@59.95Hz";
          position = "auto-right";
          scale = 1;
        }
      ];

      exec-once = [
        # Set cursor to DP-2 (primary) on startup
        "hyprctl dispatch workspace 1"
      ];

      workspace =
        (
          # 1-4 on DP-2
          builtins.genList (i: "${toString (i + 1)}, monitor:DP-2") 4
        )
        ++ (
          # 5-8 on DP-1
          builtins.genList (i: "${toString (i + 5)}, monitor:DP-1") 4
        )
        ++ [
          # 9 on HDMI-A-1
          "9, monitor:HDMI-A-1"
        ];
    };
  };
}
