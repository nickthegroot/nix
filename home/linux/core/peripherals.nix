{ pkgs, ... }:
{
  services.udiskie.enable = true;
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    bluetui
    wiremix
  ];
}
