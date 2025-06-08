{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # TODO: look into contributing darwin version
    legcord
  ];
}
