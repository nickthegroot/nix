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
    # TODO: re-enable once https://github.com/NixOS/nixpkgs/pull/523060 is in channel

    # programs._1password.enable = true;
    # programs._1password-gui.enable = true;

    # # Certain features, including CLI integration and system authentication support,
    # # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    # programs._1password-gui.polkitPolicyOwners = [ myvars.username ];
    # security.polkit.enable = true;

  };
}
