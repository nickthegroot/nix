{
  quickshell,
  pkgs,
  ...
}:
{
  programs.dms-shell = {
    enable = true;
    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Disable unneeded modules to save resources
    enableDynamicTheming = false;
    enableCalendarEvents = false;
  };
}
