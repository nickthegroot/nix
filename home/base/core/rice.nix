{ pkgs, ... }:
{
  home.packages = with pkgs; [
    astroterm
    cmatrix
  ];

  programs = {
    fastfetch.enable = true;
  };

  home.shellAliases = {
    stars = "astroterm --color --constellations --unicode";
  };
}
