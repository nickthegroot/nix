{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  home.shellAliases = {
    "clipc" = if stdenv.isDarwin then "pbcopy" else "dms cl copy";
    "clipp" = if stdenv.isDarwin then "pbpaste" else "dms cl paste";
  };
}
