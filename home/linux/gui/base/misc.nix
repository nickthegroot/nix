{pkgs, ...}: {
  home.packages = with pkgs; [
    # misc
    flameshot
  ];

  # allow fontconfig to discover fonts and configurations installed through home.packages
  # Install fonts at system-level, not user-level
  fonts.fontconfig.enable = false;
}
