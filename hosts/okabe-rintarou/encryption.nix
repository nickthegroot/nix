{
  boot.initrd.systemd.enable = true;

  boot.initrd.luks.devices.root = {
    device = "/dev/nvme0n1p2";
    preLVM = true;
    crypttabExtraOpts = [ "tpm2-device=auto" ];
  };

  # fTPM (AMD PSP) kernel modules must be available in stage 1
  boot.initrd.availableKernelModules = [ "tpm_crb" "tpm_tis" ];

  security.tpm2.enable = true;
}
