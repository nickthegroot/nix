{
  dank-material-shell,
  quickshell,
  pkgs,
  myvars,
  ...
}:
let
  # Required for idle monitoring
  # Current nixpkgs upstream is reported as "not new enough"
  quickshellPkg = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
in
{
  imports = [ dank-material-shell.nixosModules.greeter ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/${myvars.username}";

    quickshell.package = quickshellPkg;
  };
}
