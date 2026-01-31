{
  config,
  lib,
  ...
}:
let
  cfg = config.nvidia;
in
{
  options.nvidia = {
    enable = lib.mkEnableOption "Nvidia specific tools and configurations";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      settings = {
        substituters = [ "https://cache.flox.dev" ];
        trusted-public-keys = [ "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=" ];
      };
    };

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
  };
}
