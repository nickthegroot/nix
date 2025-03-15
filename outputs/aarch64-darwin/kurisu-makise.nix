{ mylib, ... }@args:
let
  name = "kurisu-makise";

  modules = {
    darwin-modules =
      (map mylib.relativeToRoot [
        # common
        "modules/darwin"
        # host specific
        "hosts/${name}"
      ])
      ++ [ ];
    home-modules = map mylib.relativeToRoot [
      "hosts/${name}/home.nix"
      "home/darwin"
    ];
  };

  systemArgs = modules // args;
in
{
  # macOS's configuration
  darwinConfigurations.${name} = mylib.macosSystem systemArgs;
}
