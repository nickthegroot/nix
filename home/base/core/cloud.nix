{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    google-cloud-sdk
    python3Packages.huggingface-hub
  ];
}
