{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.office;

  catppuccinTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "libreoffice";
    rev = "ffcbb74525eb2837b214cd5a3f2570eb7b1f3dc0";
    sha256 = "sha256-NAQJPIbJVUZFkFfdyywv1A38N06gwdLd5Uge6eqPPJM=";
  };

  inherit (config.catppuccin) accent flavor;
in
{
  options.office = {
    enable = lib.mkEnableOption "Office tools and configurations";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.libreoffice ];

    xdg.configFile."libreoffice/4/user/config/catppuccin-${flavor}-${accent}.soc".source =
      "${catppuccinTheme}/themes/${flavor}/${accent}/catppuccin-${flavor}-${accent}.soc";

    xdg.mimeApps = {
      defaultApplicationPackages = [ pkgs.libreoffice ];
    };
  };
}
