{ pkgs, nix-index-database, ... }:
let
  killport = pkgs.writeShellScriptBin "killport" ''
    #!/bin/bash
    if [ -z "$1" ]; then
      echo "Usage: killport <port>"
      exit 1
    fi
    pids=$(lsof -ti :"$1")
    if [ -z "$pids" ]; then
      echo "No processes found on port $1"
      exit 0
    fi
    echo "$pids" | xargs kill -9
    echo "Killed processes on port $1: $pids"
  '';
in
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
    killport
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
