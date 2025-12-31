{
  inputs,
  system,
  mylib,
  myvars,
  # Per-host
  name,
  darwin-modules ? [ ],
  home-modules ? [ ],
}:
let
  inherit (inputs) home-manager nix-darwin;
  specialArgs = inputs // {
    inherit mylib myvars;
  };
in
nix-darwin.lib.darwinSystem {
  inherit system specialArgs;
  modules = darwin-modules ++ [
    ../modules/darwin
    {
      system.stateVersion = 5;

      # Required to enable nix on default shell
      programs.zsh.enable = true;

      networking.hostName = name;
      networking.computerName = name;
      system.defaults.smb.NetBIOSName = name;
    }
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "home-manager.backup";

        extraSpecialArgs = specialArgs;
        users."${myvars.username}".imports = home-modules ++ [ ../home/darwin ];
      };
    }
  ];
}
