{
  config,
  lib,
  ...
}:
let
  cfg = config.work;
in
{
  options.work = {
    enable = lib.mkEnableOption "Work tools and configurations";
  };

  config = lib.mkIf cfg.enable {
    programs.brave.extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
    ];
  };
}
