{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      render-markdown = {
        enable = true;
        settings.file_types = [
          "markdown"
          "codecompanion"
        ];
      };

      lint = {
        lintersByFt.md = [ "eslint_d" ];
        linters.eslint_d.cmd = "${pkgs.eslint_d}/bin/eslint_d";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>um";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options = {
          silent = true;
          desc = "Toggle markdown preview";
        };
      }
    ];
  };
}
