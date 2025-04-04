{ lib, ... }@args:
let
  data = {
    kurisu-makise = import ./kurisu-makise.nix args;
    hiyajou-maho = import ./hiyajou-maho.nix args;
  };

  dataWithoutPaths = builtins.attrValues data;
in
{
  darwinConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.darwinConfigurations or { }) dataWithoutPaths
  );
}
