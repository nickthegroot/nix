{ pkgs, nix-index-database, ... }:
{
  imports = [ nix-index-database.hmModules.nix-index ];

  home.packages = with pkgs; [
    # Misc
    tldr
    gnupg
    gnumake
    jwt-cli

    # Modern cli tools, replacement of grep/sed/...
    # Interactively filter its input using fuzzy searching, not limit to filenames.
    fzf
    # search for files by name, faster than find
    fd
    # search for files by its content, replacement of grep
    (ripgrep.override { withPCRE2 = true; })
    # better curl
    httpie

    du-dust # A more intuitive version of `du` in rust
  ];

  programs = {
    fastfetch.enable = true;

    # A modern replacement for ‘ls’
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;

    # A command-line fuzzy finder
    fzf.enable = true;

    # A .tool-versions compatible tool downloader/switcher
    mise = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        "idiomatic_version_file_enable_tools" = [ ];
      };
    };

    # A program runner similar to npx or pipx
    # Running arbitrary nix-pkgs binaries without installing them
    nix-index-database.comma.enable = true;

    # zoxide is a smarter cd command, inspired by z and autojump.
    # It remembers which directories you use most frequently,
    # so you can "jump" to them in just a few keystrokes.
    # zoxide works on all major shells.
    #
    #   z foo              # cd into highest ranked directory matching foo
    #   z foo bar          # cd into highest ranked directory matching foo and bar
    #   z foo /            # cd into a subdirectory starting with foo
    #
    #   z ~/foo            # z also works like a regular cd command
    #   z foo/             # cd into relative path
    #   z ..               # cd one level up
    #   z -                # cd into previous directory
    #
    #   zi foo             # cd with interactive selection (using fzf)
    #
    #   z foo<SPACE><TAB>  # show interactive completions (zoxide v0.8.0+, bash 4.4+/fish/zsh only)
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.shellAliases = {
    cat = "bat";
  };
}
