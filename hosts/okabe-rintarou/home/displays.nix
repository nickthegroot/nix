{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-1,highrr,auto-left,1,transform,1"
        "DP-2,highrr,auto,1"
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
