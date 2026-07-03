{
  dankcalendar,
  dms,
  pkgs,
  ...
}:
{
  imports = [ dankcalendar.homeModules.default ];

  programs.dank-calendar = {
    enable = true;
    systemd.enable = true;
    quickshell.package = dms.packages.${pkgs.system}.quickshell;
  };
}
