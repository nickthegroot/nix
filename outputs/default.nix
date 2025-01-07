inputs: let
  inherit (inputs.nixpkgs) lib;
  mylib = import ../lib {inherit lib;};
  myvars = import ../vars;

  # Add my custom lib, vars, nixpkgs instance, and all the inputs to specialArgs,
  # so that I can use them in all my nixos/home-manager/darwin modules.
  genSpecialArgs = system:
    inputs
    // {
      inherit mylib myvars;
    };

  args = {inherit inputs lib mylib myvars genSpecialArgs;};

  nixosSystems = {
    x86_64-linux = import ./x86-linux (args // {system = "x64-linux";});
  };

  darwinSystems = {
    # TODO: Darwin Systems
  };

  nixosSystemValues = builtins.attrValues nixosSystems;
  darwinSystemValues = builtins.attrValues darwinSystems;
in {
  nixosConfigurations =
    lib.attrsets.mergeAttrsList (map (x: x.nixosConfigurations or {}) nixosSystemValues);

  darwinConfigurations =
    lib.attrsets.mergeAttrsList (map (it: it.darwinConfigurations or {}) darwinSystemValues);
}
