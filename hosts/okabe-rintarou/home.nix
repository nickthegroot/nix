{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-2,highrr,auto,1"
        "DP-1,highrr,auto-left,1,transform,1"
      ];

      workspace = [
        # Set DP-2 as primary (workspace 1)
        "1,monitor:DP-2"
      ];
    };
  };
}
