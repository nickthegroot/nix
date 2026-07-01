# Apple Silicon (Asahi Linux) support for ruka-urushibara.
# Gotchas sourced from nixos-apple-silicon/docs (uefi-standalone.md, binary-cache.md, release-notes.md).
{
  nixos-apple-silicon,
  lib,
  ...
}:
{
  imports = [ nixos-apple-silicon.nixosModules.apple-silicon-support ];

  # The Asahi kernel, U-Boot and m1n1 are large and slow to build. Use the
  # project's binary cache to substitute them instead of building locally.
  # https://github.com/nix-community/nixos-apple-silicon/blob/main/docs/binary-cache.md
  nix.settings = {
    extra-substituters = [ "https://nixos-apple-silicon.cachix.org" ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  networking.networkmanager.wifi.backend = "iwd";
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # --- aarch64 compatibility overrides for shared modules ---------------------
  # The shared modules/nixos set is authored for the x86_64 desktop host. Three
  # options don't apply to aarch64 / a laptop without an Nvidia dGPU and would
  # break evaluation, so force them off here.

  # Steam has no native aarch64 runtime (TODO)
  programs.steam.enable = lib.mkForce false;

  # xone (Xbox controller driver) is an out-of-tree kernel module without
  # aarch64 support.
  hardware.xone.enable = lib.mkForce false;

  # 32-bit ALSA support pulls in pkgsi686Linux, which only exists on x86_64.
  services.pipewire.alsa.support32Bit = lib.mkForce false;
}
