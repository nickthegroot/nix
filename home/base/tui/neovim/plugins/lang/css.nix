{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          css = ["prettierd"];
        };

        formatters.prettierd = {
          command = "${pkgs.prettierd}/bin/prettierd";
        };
      };

      lsp.servers = {
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
