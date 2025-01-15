{pkgs, ...}: {
  home.packages = with pkgs; [
    lazydocker # Docker terminal UI.
  ];

  home.shellAliases = {
    ld = "lazydocker";
    dc = "docker compose";
  };
}
