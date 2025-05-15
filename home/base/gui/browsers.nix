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
      colors.webpage.preferred_color_scheme = "dark";
    };
    keyBindings = {
      normal = {
        ",p" = "spawn --userscript qute-1pass";
      };
    };
  };
}
