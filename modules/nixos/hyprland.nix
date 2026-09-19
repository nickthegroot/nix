{ inputs, myvars, ... }:
{
  programs.hyprland.enable = true;

  imports = [ inputs.dank-greeter.nixosModules.default ];

  programs.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/${myvars.username}";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
