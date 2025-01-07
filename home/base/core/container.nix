{pkgs, ...}: {
  home.packages = with pkgs; [
    docker-compose
    lazydocker # Docker terminal UI.
  ];
}
