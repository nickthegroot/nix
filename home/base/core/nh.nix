{ myvars, pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  programs.nh = {
    enable = true;
    flake =
      if stdenv.isDarwin then
        "/Users/${myvars.username}/.dotfiles/"
      else
        "/home/${myvars.username}/.dotfiles/";
  };
}
