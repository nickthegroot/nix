{pkgs, ...}: {
  home.packages = with pkgs; [
    lazydocker # Docker terminal UI.
  ];
}
