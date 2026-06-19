{ config, lib, myvars, ... }:
let
  enabled = config.home-manager.users.${myvars.username}.language-learning.enable or false;
in
{
  config = lib.mkIf enabled {
    homebrew.casks = [ "anki" ];
  };
}
