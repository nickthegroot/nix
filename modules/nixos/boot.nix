{
  catppuccin.grub.enable = true;
  boot = {
    loader = {
      timeout = 2;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "30%";
    };
  };
}
