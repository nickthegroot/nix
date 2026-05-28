{ lib, ... }:
{
  # BIOS defaults to DP-2 as primary (e.g. grub)
  wayland.windowManager.hyprland.settings = {
    monitor = [
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

    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline "function()\n  hl.dispatch(hl.dsp.exec_cmd(\"hyprctl dispatch workspace 1\"))\nend")
      ];
    };

    workspace_rule =
      (
        # 1-4 on DP-2
        builtins.genList (i: { workspace = toString (i + 1); monitor = "DP-2"; }) 4
      )
      ++ (
        # 5-8 on DP-1
        builtins.genList (i: { workspace = toString (i + 5); monitor = "DP-1"; }) 4
      )
      ++ [
        # 9 on HDMI-A-1
        { workspace = "9"; monitor = "HDMI-A-1"; }
      ];
  };
}
