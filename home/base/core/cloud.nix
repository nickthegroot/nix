{pkgs, ...}: {
  home.packages = with pkgs; [
    awscli2
    google-cloud-sdk
    azure-cli
  ];
}
