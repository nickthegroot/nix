{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    ssm-session-manager-plugin # AWS Session Manger Plugin
    google-cloud-sdk
    # Running into a lot of problems getting this working.
    # For now, will manage through Mise/Brew
    # azure-cli
  ];
}
