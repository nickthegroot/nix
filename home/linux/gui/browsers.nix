{ pkgs, zen-browser, ... }:
{
  # Mainly for web dev / compatibility purposes, see base/gui/browsers.nix for main
  home.packages = [ zen-browser.packages.${pkgs.system}.default ];
  programs.chromium.enable = true;
}
