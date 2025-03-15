{ lib, ... }:
{
  nixpkgs.config.allowUnfree = lib.mkForce true;
  nix = {
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
    settings.auto-optimise-store = true;

    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;
  };

}
