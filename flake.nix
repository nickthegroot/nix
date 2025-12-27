{
  description = "Nick DeGroot's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Required for some dms-shell features
    # until the new version is released to nixpkgs
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell?rev=3918290c1bcd93ed81291844d9f1ed146672dbfc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: import ./hosts inputs;
}
