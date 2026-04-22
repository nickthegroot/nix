{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "monthly";
    };
  };

  home.packages = with pkgs; [
    agenix-cli
  ];
}
