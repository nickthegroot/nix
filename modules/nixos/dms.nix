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

    plugins = {
      Calculator = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "rochacbruno";
          repo = "DankCalculator";
          rev = "de6dbd59b7630e897a50e107f704c1cd4a131128";
          sha256 = "sha256-Vq+E2F2Ym5JdzjpCusRMDXd6uuAhhjAehyD/tO3omdY=";
        };
      };
    };

    # Disable unneeded modules to save resources
    enableDynamicTheming = false;
    enableCalendarEvents = false;
  };
}
