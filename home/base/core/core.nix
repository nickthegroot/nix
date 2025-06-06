{ pkgs, nix-index-database, ... }:
{
  imports = [ nix-index-database.hmModules.nix-index ];

  home.packages = with pkgs; [
    # Misc
    tldr
    gnupg
    gnumake
    jwt-cli

    # search for files by name, faster than find
    fd
    # search for files by its content, replacement of grep
    (ripgrep.override { withPCRE2 = true; })
    # A more intuitive version of `du` in rust
    du-dust
  ];

  programs = {
    fastfetch.enable = true;

    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    bat.enable = true;

    fzf.enable = true;

    mise = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        "idiomatic_version_file_enable_tools" = [ ];
      };
    };

    nix-index-database.comma.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.shellAliases = {
    cat = "bat";
  };
}
