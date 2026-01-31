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
      enable = true;
      addons = with pkgs; [
        (ankiAddons.anki-connect.withConfig {
          config.webCorsOriginList = [
            "chrome-extension://likgccmbimhjbgkjambclfkhldnlhbnn"
            "https://reader.mokuro.app"
          ];
        })
      ];

      sync = {
        url = "http://anki-sync.worldline.local";
        username = "nickthegroot";
        # TODO: use agenix to manage secrets
        # For now, just create the key file manually
        keyFile = "${config.xdg.configHome}/anki/key.txt";
      };
    };

    programs.brave.extensions = [
      { id = "likgccmbimhjbgkjambclfkhldnlhbnn"; } # Yomitan (Popup Dictionary)
      { id = "hkledmpjpaehamkiehglnbelcpdflcab"; } # asbplayer (Text-Selectable Subtitles + Anki with Screenshots)
    ];
  };
}
