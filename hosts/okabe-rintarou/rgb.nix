{ pkgs, ... }:
let
  liquidctl = "${pkgs.liquidctl}/bin/liquidctl";
in
{
  systemd.services.setCaseRgb = {
    wantedBy = [ "multi-user.target" ];
    description = "Set RGB lighting on startup";
    script = ''
      ${liquidctl} --match "Aura" set sync color static 8A00C4
      ${liquidctl} --match "Kraken" set sync color fixed 8A00C4
      ${liquidctl} --match "Smart Device" set sync color fixed 04A5E5
    '';
  };
}
