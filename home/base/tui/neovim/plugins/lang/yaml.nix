{
  programs.nixvim = {
    lsp.servers.yamlls = {
      enable = true;
      config = {
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false;
              lineFoldingOnly = true;
            };
          };
        };
      };
    };
  };
}
