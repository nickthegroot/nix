inputs:
let
  inherit (inputs.nixpkgs) lib;
  mylib = import ../lib { inherit lib; };

  packagesForSystem =
    system:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
      packageDirs = mylib.scanPaths ./.;
      packageNames = map builtins.baseNameOf packageDirs;
    in
    lib.genAttrs packageNames (name: pkgs.callPackage (./. + "/${name}/package.nix") { });
in
{
  packages = lib.genAttrs lib.systems.flakeExposed packagesForSystem;
  overlays.default =
    final: prev:
    let
      packageDirs = mylib.scanPaths ./.;
      packageNames = map builtins.baseNameOf packageDirs;
    in
    lib.genAttrs packageNames (name: final.callPackage (./. + "/${name}/package.nix") { });
}

