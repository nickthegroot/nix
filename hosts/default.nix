inputs:
let
  inherit (inputs.nixpkgs) lib;
  mylib = import ../lib { inherit lib; };
  myvars = import ../vars;

  createSystem =
    wrapper: system: hostPath:
    let
      systemConfig = import hostPath;
    in
    {
      inherit (systemConfig) name;
      value = wrapper (
        systemConfig
        // {
          inherit
            inputs
            system
            mylib
            myvars
            ;
        }
      );
    };

  createSystems =
    wrapper: hosts:
    lib.lists.flatten (
      lib.attrsets.mapAttrsToList (system: hostPaths: map (createSystem wrapper system) hostPaths) hosts
    );

  nixosHosts = {
    x86_64-linux = [ ./okabe-rintarou ];
  };
  darwinHosts = {
    aarch64-darwin = [
      ./hiyajou-maho
      ./kurisu-makise
    ];
  };

  nixosSystems = createSystems mylib.nixosSystem nixosHosts;
  darwinSystems = createSystems mylib.darwinSystem darwinHosts;
in
{
  nixosConfigurations = builtins.listToAttrs nixosSystems;
  darwinConfigurations = builtins.listToAttrs darwinSystems;
}
