{ catppuccin, ... }:
{
  # Global setup handled in home/base/catppuccin.nix
  imports = [ catppuccin.nixosModules.catppuccin ];
}
