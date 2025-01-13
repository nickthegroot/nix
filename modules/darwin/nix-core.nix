{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade the nix-daemon service.
  services.nix-daemon.enable = true;

  # Disable auto-optimise-store because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
  nix.settings.auto-optimise-store = false;

  nix.gc.automatic = false;

  system.stateVersion = 5;
}
