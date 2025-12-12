{
  dank-material-shell,
  myvars,
  ...
}:
{
  imports = [ dank-material-shell.nixosModules.greeter ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/${myvars.username}";
  };
}
