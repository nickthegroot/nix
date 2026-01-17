{ pkgs, ... }:
let
  heroicThemeSrc = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "heroic";
    rev = "1248e2d24721aa1cc54f185b1b851826207a2b46";
    sha256 = "sha256-JcLvp/7F+lmU8FVkrMvgtnu087XLS1T3/3X6OrA/yOg=";
  };
in
{
  home.packages = with pkgs; [
    # Extra pkgs required for some games, e.g. Hypnospace Outlaw
    (heroic.override {
      extraPkgs =
        pkgs: with pkgs; [
          speechd
        ];
      extraLibraries =
        pkgs: with pkgs; [
          nss
          nspr
          atk
          libdrm
          expat
          xorg.libXdamage
          libgbm
        ];
    })

    prismlauncher
    unnamed-sdvx-clone
  ];

  xdg.configFile."heroic/CustomThemes/catppuccin".source = heroicThemeSrc + "/themes";

  programs.mangohud = {
    enable = true;
    settings = {
      no_display = true; # hide hud by default (Shift_R+F12 to toggle)
      preset = 3; # extended view
    };
  };
}
