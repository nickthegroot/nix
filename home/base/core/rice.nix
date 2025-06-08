{ pkgs, ... }:
{
  home.packages = with pkgs; [
    astroterm
  ];

  programs = {
    fastfetch.enable = true;
  };
}
