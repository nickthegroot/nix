{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          css = ["biome"];
        };
      };

      lsp.servers = {
        biome = {
          enable = true;
          filetypes = [
            "css"
          ];
        };

        cssls = {
          enable = true;
          cmd = [
            "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server"
            "--stdio"
          ];
        };

        tailwindcss = {
          enable = true;
          cmd = [
            (lib.getExe pkgs.tailwindcss-language-server)
            "--stdio"
          ];
        };
      };
    };
  };
}
