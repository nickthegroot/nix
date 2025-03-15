{ pkgs, ... }:
{
  home.pointerCursor = {
    size = 24;
    name = "catppuccin-mocha-light-cursors";
    package = pkgs.catppuccin-cursors.mochaLight;
  };
}
