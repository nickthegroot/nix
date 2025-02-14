{pkgs, ...}: {
  home.packages = with pkgs; [
    anki
  ];

  wayland.windowManager.hyprland = {
    settings = {
      env = [
        # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "AQ_DRM_DEVICES,/dev/dri/card1"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # fix https://github.com/hyprwm/Hyprland/issues/1520
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      monitor = [
        "DP-2,2560x1440@143.91Hz,auto,1"
        "DP-1,3440x1440@159.96Hz,auto-left,1"
      ];
    };
  };

  # Widescreen monitor is on an arm, which allows me to use in vertical
  home.shellAliases = {
    "monitor-vert" = "hyprctl keyword monitor DP-1,3440x1440@159.96Hz,auto-left,1,transform,3";
    "monitor-horiz" = "hyprctl keyword monitor DP-1,3440x1440@159.96Hz,auto-left,1";
  };
}
