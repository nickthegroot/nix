{lib, ...} @ args: let
  data = {
    okabe-rintarou = import ./src/okabe-rintarou.nix args;
  };

  dataWithoutPaths = builtins.attrValues data;
in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
}
