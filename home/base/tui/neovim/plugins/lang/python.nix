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

    lsp.servers =
      let
        config = {
          root_markers = [ ".venv" ];
        };
      in
      {
        ty = {
          enable = true;
          inherit config;
        };
        ruff = {
          enable = true;
          inherit config;
        };
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
