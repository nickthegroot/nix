{ pkgs, zen-browser, ... }:
{
  home.packages = [ zen-browser.packages.${pkgs.system}.default ];

  programs = {
    chromium.enable = true;
    qutebrowser.enable = true;
  };
}
