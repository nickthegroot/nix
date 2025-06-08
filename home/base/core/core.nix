{ pkgs, nix-index-database, ... }:
{
  imports = [ nix-index-database.hmModules.nix-index ];

  home.packages = with pkgs; [
    # Common tools
    gnupg
    gnumake

    # Better versions of common tools
    (ripgrep.override { withPCRE2 = true; }) # better grep
    fd # better find
    xh # better httpie/curl
    du-dust # better du
    duf # better df
    caligula # better dd

    # More specialized tools
    jwt-cli
    pastel

    # Helpers/Misc
    tldr
  ];

  programs = {
    fzf.enable = true;
    nix-index-database.comma.enable = true;

    # Better ls
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    # Better cat
    bat.enable = true;

    # Better asdf (.tool-versions)
    # TODO: look into replacing with nix develop
    mise = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        "idiomatic_version_file_enable_tools" = [ ];
      };
    };

    # Smarter cd
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.shellAliases = {
    cat = "bat";
  };
}
