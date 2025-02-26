{pkgs, ...}: {
  home.packages = with pkgs; [
    posting # Postman-like tool for CLI
  ];
}
