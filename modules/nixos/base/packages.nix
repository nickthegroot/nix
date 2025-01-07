{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # system monitoring
    iotop
    iftop
    btop

    gparted
  ];
}
