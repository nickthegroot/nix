{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  inherit (pkgs-unstable) proton-pass proton-pass-cli;
in
{
  home.packages = [
    proton-pass
    proton-pass-cli
  ];

  programs.brave.extensions = [
    { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
  ];

  services.proton-pass-agent = {
    enable = true;
    package = proton-pass-cli;
  };

  # Force DBus keyring for consistent encryption key across interactive shells
  # and the systemd user service. Must match so both can open the same DB.
  home.sessionVariables = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    PROTON_PASS_LINUX_KEYRING = "dbus";
  };

  systemd.user.services.proton-pass-agent = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    Unit.After = [ "dbus.service" ];
    Service = {
      Restart = lib.mkForce "always";
      RestartSec = "10";
      Environment = [ "PROTON_PASS_LINUX_KEYRING=dbus" ];
    };
  };

  launchd.agents.proton-pass-agent.config.ThrottleInterval = 10;
}
