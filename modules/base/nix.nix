{
  nix = {
    settings.auto-optimise-store = true;

    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;
  };

}
