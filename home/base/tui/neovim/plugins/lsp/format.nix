{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = # Lua
          ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              return { timeout_ms = 200, lsp_fallback = true }, on_format
             end
          '';
        format_after_save = # Lua
          ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              return { lsp_fallback = true }
            end
          '';

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
        key = "<leader>tf";
        action = "<cmd>lua vim.b.disable_autoformat = not vim.b.disable_autoformat<cr>";
        options = {
          silent = true;
          desc = "Toggle Autoformat (buffer)";
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>tF";
        action = "<cmd>lua vim.g.disable_autoformat = not vim.g.disable_autoformat<cr>";
        options = {
          silent = true;
          desc = "Toggle Autoformat (global)";
        };
      }
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
