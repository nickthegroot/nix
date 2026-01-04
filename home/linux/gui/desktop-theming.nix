{ pkgs, config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "0xFFB4A1DB";
      "col.inactive_border" = "0xFF343A40";
    };

    decoration = {
      rounding = 8;
      active_opacity = 1.0;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    windowrulev2 = [
      # Open DMS windows as floating by default
      "float, class:^(org.quickshell)$"
    ];
  };

  xdg.dataFile."color-schemes".source =
    let
      cfg = config.catppuccin;
      pkg = pkgs.catppuccin-kde.override {
        flavour = [ cfg.flavor ];
        accents = [ cfg.accent ];
      };
    in
    "${pkg}/share/color-schemes";

  # Explicitly define (vs. catpuccin.cursors) to reduce size
  home.pointerCursor = {
    size = 24;
    name = "catppuccin-mocha-light-cursors";
    package = pkgs.catppuccin-cursors.mochaLight;
  };
}
