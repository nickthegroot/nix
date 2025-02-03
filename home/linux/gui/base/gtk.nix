{
  pkgs,
  config,
  ...
}: {
  catppuccin.cursors = {
    enable = true;
    accent = "light";
  };
  home.pointerCursor.size = 24;

  # gtk's theme settings, generate files:
  #   1. ~/.gtkrc-2.0
  #   2. ~/.config/gtk-3.0/settings.ini
  #   3. ~/.config/gtk-4.0/settings.ini
  gtk = {
    enable = true;

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 11;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # theme = {
    #   # https://github.com/catppuccin/gtk
    #   name = "catppuccin-macchiato-pink-compact";
    #   package = pkgs.catppuccin-gtk.override {
    #     # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/data/themes/catppuccin-gtk/default.nix
    #     accents = ["pink"];
    #     size = "compact";
    #     variant = "macchiato";
    #   };
    # };
  };
}
