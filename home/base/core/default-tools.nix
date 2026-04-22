{ pkgs, ... }:
{
  # NOTE: for any long-term development, this should be handled by a nix develop shell
  #       this is more for quick one-off scripts / testing
  home.packages = with pkgs; [
    # Node / JavaScript
    nodejs
    yarn
    pnpm
  ];
}
