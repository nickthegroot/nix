{ pkgs, ... }:
{
  home.packages = with pkgs; [
    astroterm
  ];

  programs = {
    fastfetch.enable = true;
  };

  home.shellAliases = {
    stars = "astroterm --color --constellations --unicode";
  };
}
