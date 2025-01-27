{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          json = ["biome"];
        };

        formatters.biome = {
          command = "${pkgs.biome}/bin/biome";
        };
      };

      lsp.servers = {
        biome = {
          enable = true;
          filetypes = [
            "json"
            "jsonc"
          ];
        };

        jsonls = {
          enable = true;
        };
      };
    };
  };
}
