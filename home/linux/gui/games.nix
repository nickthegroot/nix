{ pkgs, ... }:
{
  home.packages = with pkgs; [
    heroic

    unnamed-sdvx-clone
    osu-lazer-bin
  ];

  programs.mangohud = {
    enable = true;
    settings = {
      no_display = true; # hide hud by default
      preset = 3; # extended view
    };
  };
}
