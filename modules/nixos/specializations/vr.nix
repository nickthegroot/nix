# Based on https://skiletro.com/posts/2025-06-20-vr-plus-nixos-plus-nvidia/
{
  config,
  lib,
  pkgs,
  myvars,
  ...
}:
let
  enabled = config.home-manager.users.${myvars.username}.vr.enable or false;
in
{
  config = lib.mkIf enabled {
    services.wivrn = {
      enable = true;
      openFirewall = true;
      steam.importOXRRuntimes = true;
    };

    environment.systemPackages = with pkgs; [
      android-tools # Wired WiVRn
      wayvr # In-VR overlay (formerly wlx-overlay-s)
    ];
  };
}
