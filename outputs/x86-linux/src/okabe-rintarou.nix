{mylib, ...} @ args: let
  name = "okabe-rintarou";
  base-modules = {
    nixos-modules = map mylib.relativeToRoot [
      # common
      "modules/nixos/desktop.nix"
      # host specific
      "hosts/${name}"
    ];
    home-modules = map mylib.relativeToRoot [
      # common
      "home/linux/gui.nix"
      # host specific
      "hosts/${name}/home.nix"
    ];
  };
in {
  nixosConfigurations = {
    ${name} = mylib.nixosSystem (base-modules // args);
  };
}
