{ dankcalendar, ... }:
{
  imports = [ dankcalendar.homeModules.default ];

  programs.dank-calendar = {
    enable = true;
    systemd.enable = true;
  };
}
