{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        formatters_by_ft = {
          # Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
          "_" = [
            "trim_whitespace"
            "trim_newlines"
          ];
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format";
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>co";
        action = "<cmd>lua vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.organizeImports' }, diagnostics = {} } })<cr>";
        options = {
          silent = true;
          desc = "Organize Imports";
        };
      }
    ];
  };
}
