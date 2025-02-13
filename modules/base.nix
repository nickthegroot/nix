{
  pkgs,
  myvars,
  ...
}: {
  # auto upgrade nix to the unstable version
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/package-management/nix/default.nix#L284
  nix.package = pkgs.nixVersions.latest;

  # for security reasons, do not load neovim's user config
  # since EDITOR may be used to edit some critical files
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    # core tools
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git # used by nix flakes
    git-lfs # used by huggingface models

    # archives
    zip
    xz
    unzip
    p7zip

    # Text Processing
    jq # A lightweight and flexible command-line JSON processor

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
  programs.fish.enable = true;

  users.users.${myvars.username} = {
    description = myvars.userfullname;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
