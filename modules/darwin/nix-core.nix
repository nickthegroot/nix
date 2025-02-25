{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Required to enable nix on default shell
  programs.zsh.enable = true;

  system.stateVersion = 5;
}
