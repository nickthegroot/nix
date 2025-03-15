{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    ssm-session-manager-plugin # AWS Session Manger Plugin
    google-cloud-sdk
    azure-cli
  ];
}
