{ pkgs, ... }:
{
  home.packages = with pkgs; [
    heroic
    mangohud

    unnamed-sdvx-clone
    osu-lazer-bin
  ];
}
