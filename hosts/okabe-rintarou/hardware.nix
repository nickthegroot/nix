{ nixos-hardware, config, ... }:
{
  imports = with nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-pc
    common-pc-ssd
  ];

  # https://nixos.wiki/wiki/Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;

    # https://wiki.hypr.land/Nvidia/#suspendwakeup-issues
    powerManagement.enable = true;
  };

  environment.variables = {
    # https://wiki.hyprland.org/Nvidia/#environment-variables
    LIBVA_DRIVER_NAME = "nvidia";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";

    # https://wiki.hyprland.org/Nvidia/#va-api-hardware-video-acceleration
    "NVD_BACKEND" = "direct";
  };

  programs.xppen.enable = true;
  systemd.user.services.xppen-daemon = {
    # Auto start XPPen tablet service with graphical session
    description = "XPPen Pen Tablet Service";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${config.programs.xppen.package}/bin/PenTablet /mini";
  };
}
