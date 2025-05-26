{ pkgs, ... }:
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
    osu-lazer-bin
  ];

  programs.mangohud = {
    enable = true;
    settings = {
      no_display = true; # hide hud by default
      preset = 3; # extended view
    };
  };
}
