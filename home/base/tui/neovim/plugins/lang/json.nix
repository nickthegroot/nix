{
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          json = ["biome"];
        };
      };

      lsp.servers = {
        jsonls.enable = true;
        biome = {
          enable = true;
          filetypes = [
            "json"
            "jsonc"
          ];
        };
      };
    };
  };
}
