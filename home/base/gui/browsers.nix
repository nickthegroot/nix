{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  programs = {
    brave = {
      enable = true;

      # Use brew version on darwin
      package = if stdenv.isDarwin then null else pkgs.brave;

      extensions = [
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium (manual: ./vimium-options.json)
        { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # React Developer Tools
        { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus (manual: https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json)
      ];
    };
  };
}
