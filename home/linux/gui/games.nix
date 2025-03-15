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
      # pre defined presets
      # -1 = default
      #  0 = no display
      #  1 = fps only
      #  2 = horizontal view
      #  3 = extended
      #  4 = high detailed information
      preset = 3;
    };
  };
}
