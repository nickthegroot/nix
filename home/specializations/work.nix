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
    programs.opencode.settings.mcp = {
      linear = {
        type = "remote";
        url = "https://mcp.linear.app/mcp";
      };

      metabase = {
        type = "remote";
        url = "https://metabase.digs.com/api/mcp";
      };
    };

    programs.brave.extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
    ];
  };
}
