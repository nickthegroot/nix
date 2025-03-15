{ pkgs, ... }:
let
  inherit (pkgs) writeShellScript;

  liquidctl = "${pkgs.liquidctl}/bin/liquidctl";
  setCaseRgb = writeShellScript "set-rgb" ''
    ${liquidctl} --match "Aura" set sync color static 8A00C4
    ${liquidctl} --match "Kraken" set sync color fixed 8A00C4
    ${liquidctl} --match "Smart Device" set sync color fixed 04A5E5
  '';
in
{
  systemd.services.setCaseRgb = {
    wantedBy = [ "multi-user.target" ];
    description = "Set RGB lighting on startup";
    script = setCaseRgb;
  };
}
