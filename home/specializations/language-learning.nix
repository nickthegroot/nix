{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.language-learning;
in
{
  options.language-learning = {
    enable = lib.mkEnableOption "Language learning tools and configurations";
  };

  config = lib.mkIf cfg.enable {
    programs.anki = {
      # https://github.com/NixOS/nixpkgs/issues/514179
      # On darwin, the Homebrew cask is installed by modules/darwin/language-learning.nix
      enable = !pkgs.stdenv.isDarwin;
      addons = with pkgs; [
        (ankiAddons.anki-connect.withConfig {
          config.webCorsOriginList = [
            "chrome-extension://likgccmbimhjbgkjambclfkhldnlhbnn"
            "http://mokuro.worldline.local"
          ];
        })
      ];

      profiles."User 1".sync = {
        url = "http://anki-sync.worldline.local";
        username = "nickthegroot";
        # TODO: use agenix to manage secrets
        # For now, just create the key file manually
        keyFile = "${config.xdg.configHome}/anki/key.txt";
      };
    };

    programs.brave.extensions = [
      { id = "likgccmbimhjbgkjambclfkhldnlhbnn"; } # Yomitan (Popup Dictionary)
    ];
  };
}
