{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playball
  ];
}
