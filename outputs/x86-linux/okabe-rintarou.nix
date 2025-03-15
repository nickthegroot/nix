{ mylib, ... }@args:
let
  name = "okabe-rintarou";
  base-modules = {
    nixos-modules = map mylib.relativeToRoot [
      # common
      "modules/nixos"
      # host specific
      "hosts/${name}"
    ];
    home-modules = map mylib.relativeToRoot [
      "hosts/${name}/home.nix"
      "home/linux"
    ];
  };
in
{
  nixosConfigurations = {
    ${name} = mylib.nixosSystem (base-modules // args);
  };
}
