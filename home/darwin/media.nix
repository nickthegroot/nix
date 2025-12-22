{ pkgs, ... }:
{
  home.packages = with pkgs; [
    iina # native mpv alternative for macOS
  ];
}
