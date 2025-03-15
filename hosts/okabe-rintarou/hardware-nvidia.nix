# https://nixos.wiki/wiki/Nvidia
{ config, ... }:
{
  hardware.graphics.enable = true;

  # Loads for Xorg & Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # An important note to take is that the option hardware.nvidia.open should only be set to false if you have a GPU with an older architecture than Turing (older than the RTX 20-Series).
    #
    # For newer cards it is recommended by NVIDIA to use the open Drivers: https://download.nvidia.com/XFree86/Linux-x86_64/565.77/README/kernel_open.html
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.variables = {
    # https://wiki.hyprland.org/Nvidia/#environment-variables
    LIBVA_DRIVER_NAME = "nvidia";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";

    # https://wiki.hyprland.org/Nvidia/#va-api-hardware-video-acceleration
    "NVD_BACKEND" = "direct";
  };
}
