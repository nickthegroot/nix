{ dank-material-shell, ... }:
{
  imports = [ dank-material-shell.nixosModules.greeter ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
  };
}
