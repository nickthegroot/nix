{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  programs.ghostty = {
    enable = true;
    package =
      # use brew version on darwin (nixpkg currently broken)
      if stdenv.isDarwin then null else pkgs.ghostty;
    settings = {
      font-family = "JetBrainsMono Nerd Font";

      background-opacity = 0.93;
      confirm-close-surface = false;

      # only supported on macOS
      background-blur-radius = 10;
      macos-titlebar-style = "hidden";

      # only supported on Linux
      gtk-titlebar = false;

      command = "${pkgs.fish}/bin/fish --login --interactive";
    };
  };
}
