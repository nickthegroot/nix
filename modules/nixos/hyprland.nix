{ myvars, pkgs, ... }:
{
  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/start-hyprland";
        user = myvars.username;
      };
      default_session = initial_session;
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
