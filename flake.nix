{
  description = "Nick DeGroot's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oh-my-pi = {
      url = "github:can1357/oh-my-pi";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:duxlabs-dev/dux-shell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dank-greeter = {
      url = "github:duxlabs-dev/dux-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:duxlabs-dev/dux-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankcalendar = {
      url = "github:duxlabs-dev/dux-calendar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dfiles = {
      url = "github:duxlabs-dev/dux-files";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: (import ./hosts inputs) // (import ./packages inputs);
}
