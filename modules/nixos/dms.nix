{
  myvars,
  quickshell,
  pkgs,
  ...
}:
{
  services.displayManager.dms-greeter = {
    enable = true;
    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

    compositor.name = "hyprland";
    configHome = "/home/${myvars.username}";
  };

  programs.dms-shell = {
    enable = true;
    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Disable unneeded modules to save resources
    enableDynamicTheming = false;
    enableCalendarEvents = false;
  };
}
