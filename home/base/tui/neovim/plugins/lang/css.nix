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

        formatters.biome = {
          command = "${pkgs.biome}/bin/biome";
        };
      };

      lsp.servers = {
        biome = {
          enable = true;
          filetypes = [
            "css"
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
