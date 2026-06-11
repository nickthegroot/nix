{ dms, dms-plugin-registry, ... }:
{
  imports = [
    dms.homeModules.dank-material-shell
    dms-plugin-registry.homeModules.default
  ];

  programs.dank-material-shell = {
    enable = true;

    # Disable unneeded modules to save resources
    enableDynamicTheming = false;
    enableCalendarEvents = false;

    plugins.calculator = {
      enable = true;
      settings.calcEngine = "qalc";
    };

    systemd.enable = true;
  };
}
