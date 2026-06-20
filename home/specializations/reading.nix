{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.reading;
in
{
  options.reading = {
    enable = lib.mkEnableOption "Reading tools and configurations";
  };

  config = lib.mkIf cfg.enable {
    programs.calibre.enable = true;

    # TODO: repackage such that can auto-add as calibre plugin
    # See: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fanficfare
    home.packages = with pkgs; [
      (fanficfare.overrideAttrs (
        # https://github.com/JimmXinu/FanFicFare/releases
        finalAttrs: previousAttrs: {
          version = "4.58.1";
          src = fetchPypi {
            inherit (finalAttrs) pname version;
            hash = "sha256-5w1ubvRmhe/hWagp7n031WUulbmUznNVGk+gyXcFSUg=";
          };

          propagatedBuildInputs = previousAttrs.propagatedBuildInputs ++ (with python3Packages; [ apsw ]);
        }
      ))
    ];
  };
}
