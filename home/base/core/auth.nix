{ pkgs, ... }:
{
  home.packages = with pkgs; [
    proton-pass
    proton-pass-cli
  ];

  services.proton-pass-agent.enable = true;

  programs.brave.extensions = [
    { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
  ];
}
