{ catppuccin, pkgs, ... }:
{
  # Global setup handled in home/base/catppuccin.nix
  imports = [ catppuccin.nixosModules.catppuccin ];

  environment.systemPackages = with pkgs; [
  ];
}
