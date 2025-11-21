{ nixos-hardware, ... }:
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
  hardware.nvidia.open = true;

  environment.variables = {
    # https://wiki.hyprland.org/Nvidia/#environment-variables
    LIBVA_DRIVER_NAME = "nvidia";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";

    # https://wiki.hyprland.org/Nvidia/#va-api-hardware-video-acceleration
    "NVD_BACKEND" = "direct";
  };

}
