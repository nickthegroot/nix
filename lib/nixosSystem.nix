{
  inputs,
  system,
  mylib,
  myvars,
  # Per-host
  name,
  nixos-modules,
  home-modules ? [ ],
}:
let
  inherit (inputs) nixpkgs home-manager;
  specialArgs = inputs // {
    inherit mylib myvars;
  };
in
nixpkgs.lib.nixosSystem {
  inherit system specialArgs;
  modules = nixos-modules ++ [
    ../modules/nixos
    {
      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "24.11"; # Did you read the comment?

      networking = {
        hostName = name;
        networkmanager.enable = true;
      };
    }
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "home-manager.backup";

        extraSpecialArgs = specialArgs;
        users."${myvars.username}".imports = home-modules ++ [ ../home/linux ];
      };
    }
  ];
}
