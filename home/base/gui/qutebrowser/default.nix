{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  programs.qutebrowser = {
    enable = true;
    package =
      # use brew version on darwin
      if stdenv.isDarwin then pkgs.emptyDirectory else pkgs.qutebrowser;
    settings = {
      window.hide_decoration = true;

      colors.webpage.darkmode = {
        enabled = true;
        algorithm = "lightness-cielab";
        policy.images = "never";
      };

      auto_save = {
        interval = 10000;
        session = true;
      };
    };
    keyBindings = {
      normal = {
        "tT" = "config-cycle tabs.position top left";
        "tD" = "config-cycle statusbar.show always never";
        "td" = "config-cycle -p -u *://{url:host}/* colors.webpage.darkmode.enabled false true ;; reload";
      };
    };
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      g = "https://www.google.com/search?hl=en&amp;q={}";
      nx = "https://mynixos.com/search?q={}";
      gh = "https://github.com/search?o=desc&q={}&s=stars";
    };
  };
}
