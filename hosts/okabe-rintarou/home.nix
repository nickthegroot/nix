{
  modules.desktop = {
    hyprland = {
      nvidia = true;
      settings = {
        monitor = [
          "DP-2,2560x1440@143.91Hz,auto,1"
          "DP-1,3440x1440@159.96Hz,auto-left,1"
        ];
      };
    };
  };

  # Widescreen monitor is on an arm, which allows me to use in vertical
  home.shellAliases = {
    "monitor-vert" = "hyprctl keyword monitor DP-1,3440x1440@159.96Hz,auto-left,1,transform,3";
    "monitor-horiz" = "hyprctl keyword monitor DP-1,3440x1440@159.96Hz,auto-left,1";
  };
}
