{ nixos-hardware, config, ... }:
{
  imports = with nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-pc
    common-pc-ssd
  ];

  nvidia.enable = true;
  programs.xppen.enable = true;

  systemd.user.services.xppen-daemon = {
    # Auto start XPPen tablet service with graphical session
    description = "XPPen Pen Tablet Service";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${config.programs.xppen.package}/bin/PenTablet /mini";
  };
}
