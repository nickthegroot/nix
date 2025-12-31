{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnugrep
    gnutar
  ];
}
