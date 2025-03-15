{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pgcli # Better pgadmin
  ];
}
