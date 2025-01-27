{
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          graphql = ["biome"];
        };
      };

      lsp.servers = {
        graphql.enable = true;
        biome = {
          enable = true;
          filetypes = [
            "graphql"
          ];
        };
      };
    };
  };
}
