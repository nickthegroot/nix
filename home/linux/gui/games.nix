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
      full = true; # show (most) parameters
      no_display = true; # hide hud by default
    };
  };
}
