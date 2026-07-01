# PLACEHOLDER — regenerate on the machine after partitioning:
#   nixos-generate-config --root /mnt
# then replace this file with /mnt/etc/nixos/hardware-configuration.nix.
#
# Asahi partition layout (see nixos-apple-silicon/docs/uefi-standalone.md):
#   - root:   /dev/disk/by-label/nixos (ext4)
#   - ESP:    /dev/disk/by-partuuid/<asahi,efi-system-partition> (vfat)
# The ESP partuuid is read from the device tree at install time, so the
# generated file will contain the real UUID in place of the placeholder below.
{
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partuuid/00000000-0000-0000-0000-000000000000";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  nixpkgs.hostPlatform = "aarch64-linux";
}
