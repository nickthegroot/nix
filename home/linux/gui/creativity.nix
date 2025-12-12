{ pkgs, ... }:
{
  home.packages = with pkgs; [
    krita
  ];

  xdg.dataFile."krita/color-schemes".source = pkgs.fetchzip {
    url = "https://github.com/catppuccin/kde/releases/download/v0.2.6/Mocha-color-schemes.tar.gz";
    hash = "sha256-I5WIXubfArLsrELLdWvuN66VsQ3dr7PzxYBlzz9qBBI=";
  };
}
