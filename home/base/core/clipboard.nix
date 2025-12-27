{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  home.shellAliases = {
    "clipc" = if stdenv.isDarwin then "pbcopy" else "wl-copy";
    "clipp" = if stdenv.isDarwin then "pbpaste" else "wl-paste";
  };
}
