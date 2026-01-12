{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.work-digs;
in
{
  options.work-digs = {
    enable = lib.mkEnableOption "Apps & configs for working at Digs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      slack
    ];
  };
}
