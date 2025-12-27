{
  pkgs,
  config,
  ...
}:
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

    layerrule = [ "noanim, ^(dms)$" ];
    windowrulev2 = [
      # Open DMS windows as floating by default
      "float, class:^(org.quickshell)$"
    ];
  };

  gtk.theme =
    let
      cfg = config.catppuccin;
      size = "standard";
    in
    {
      name = "catppuccin-${cfg.flavor}-${cfg.accent}-${size}";
      package = pkgs.catppuccin-gtk.override {
        inherit size;
        accents = [ cfg.accent ];
        variant = cfg.flavor;
      };
    };

  xdg.configFile =
    let
      gtk4Dir = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0";
    in
    {
      "gtk-4.0/assets".source = "${gtk4Dir}/assets";
      "gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
    };

  home.pointerCursor = {
    size = 24;
    name = "catppuccin-mocha-light-cursors";
    package = pkgs.catppuccin-cursors.mochaLight;
  };
}
