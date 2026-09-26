# Based on https://skiletro.com/posts/2025-06-20-vr-plus-nixos-plus-nvidia/
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.vr;
  steam = "${config.xdg.dataHome}/Steam";
in
{
  options.vr = {
    enable = lib.mkEnableOption "VR tools and configurations";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."openvr/openvrpaths.vrpath".text = builtins.toJSON {
      version = 1;
      jsonid = "vrpathreg";
      external_drivers = null;
      config = [ "${steam}/config" ];
      log = [ "${steam}/logs" ];
      runtime = [ "${pkgs.opencomposite}/lib/opencomposite" ];
    };
  };
}
