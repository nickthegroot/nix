{
  # BIOS defaults to DP-2 as primary (e.g. grub)
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-1,highrr,auto,1,transform,1"
        "DP-2,highrr,auto-right,1"
      ];

      exec-once = [
        # Set cursor to DP-2 (primary) on startup
        "hyprctl dispatch workspace 1"
      ];

      workspace =
        (
          # 1-5 on DP-2
          builtins.genList (i: "${toString (i + 1)}, monitor:DP-2") 5
        )
        ++ (
          # 6-9 on DP-1
          builtins.genList (i: "${toString (i + 6)}, monitor:DP-1") 4
        );
    };
  };
}
