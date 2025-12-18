{
  programs.nixvim = {
    plugins = {
      venv-selector.enable = true;
      conform-nvim.settings = {
        formatters_by_ft.python = [
          "ruff_format"
          "ruff_organize_imports"
        ];
      };
    };

    lsp.servers = {
      ty.enable = true;
      ruff.enable = true;
    };

    keymaps = [
      {
        mode = [
          "n"
        ];
        key = "<leader>cv";
        action = ":VenvSelect<CR>";
        options = {
          silent = true;
          desc = "Select python environment";
        };
      }
    ];
  };
}
