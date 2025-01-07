{pkgs, ...}: {
  home.packages = with pkgs; (
    # -*- Data & Configuration Languages -*-#
    [
      #-- nix
      nil
      alejandra # Nix Code Formatter

      #-- json like
      # terraform  # install via brew on macOS
      terraform-ls
      jsonnet
      jsonnet-language-server
      taplo # TOML language server / formatter / validator
      nodePackages.yaml-language-server
      actionlint # GitHub Actions linter

      #-- dockerfile
      hadolint # Dockerfile linter
      nodePackages.dockerfile-language-server-nodejs

      #-- markdown
      marksman # language server for markdown
      glow # markdown previewer
    ]
    ++
    #-*- General Purpose Languages -*-#
    [
      #-- python
      pyright # python language server
      (python311.withPackages (
        ps:
          with ps; [
            ruff
            black # python formatter
          ]
      ))

      #-- lua
      stylua
      lua-language-server

      #-- bash
      nodePackages.bash-language-server
      shellcheck
      shfmt
    ]
    #-*- Web Development -*-#
    ++ [
      nodePackages.nodejs
      nodePackages.typescript
      nodePackages.typescript-language-server
      # HTML/CSS/JSON/ESLint language servers extracted from vscode
      nodePackages.vscode-langservers-extracted
      nodePackages."@tailwindcss/language-server"
    ]
    ++ [
      #-- Optional Requirements:
      nodePackages.prettier # common code formatter
      fzf
      (ripgrep.override {withPCRE2 = true;}) # recursively searches directories for a regex pattern
    ]
  );
}
