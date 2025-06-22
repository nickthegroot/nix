{
  lib,
  config,
  myvars,
  ...
}:
with lib;
{
  options.modules.ssh.key = mkOption {
    type = types.str;
    default = "";
  };

  config = lib.mkIf (config.modules.ssh.key != "") {
    services.openssh.enable = true;
    users.users.${myvars.username}.openssh.authorizedKeys.keys = [
      config.modules.ssh.key
    ];
  };
}
