{
  pkgs,
  lib,
  mylib,
  myvars,
  ...
}:
{
  imports = mylib.scanPaths ./.;

  # auto upgrade nix to the unstable version
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/package-management/nix/default.nix#L284
  nix.package = pkgs.nixVersions.latest;

  # for security reasons, do not load neovim's user config
  # since EDITOR may be used to edit some critical files
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    neovim
    git
    git-lfs

    # archives
    zip
    unzip
    p7zip

    # Text Processing
    jq

    # networking tools
    wget
    curl

    # misc
    which
    tree
    gnutar
    rsync
  ];

  # Install completion scripts
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  users.users.${myvars.username} = {
    description = myvars.userfullname;
  };

  nixpkgs.config.allowUnfree = lib.mkForce true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
