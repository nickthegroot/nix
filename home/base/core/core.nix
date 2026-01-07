{ pkgs, nix-index-database, ... }:
{
  imports = [ nix-index-database.homeModules.nix-index ];

  home.packages = with pkgs; [
    # Common tools
    gnupg
    gnumake

    # Better versions of common tools
    fd # better find
    xh # better httpie/curl
    dust # better du
    duf # better df
    caligula # better dd

    # More specialized tools
    jwt-cli
    pastel
    graphviz

    # Helpers/Misc
    tldr
  ];

  programs = {
    fzf.enable = true;
    nix-index-database.comma.enable = true;

    # Better grep
    ripgrep.enable = true;

    # Better ls
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    # Better cat
    bat.enable = true;

    # Tool version management
    # (legacy - `nix develop` + direnv is preferred)
    mise.enable = true;

    # Smart environment management
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Smarter cd
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.shellAliases = {
    cat = "bat";
    http = "xh";
  };
}
