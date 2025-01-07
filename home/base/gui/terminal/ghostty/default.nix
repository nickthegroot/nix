{
  config,
  pkgs,
  lib,
  ghostty,
  ...
}:
###########################################################
#
# Ghostty Configuration
#
###########################################################
{
  xdg.configFile."ghostty/config".source = ./config;

  # Flake is only supported on NixOS, install with brew otherwise
  home.packages =
    if pkgs.stdenv.isLinux
    then [ghostty.packages.${pkgs.system}.default]
    else [];
}
