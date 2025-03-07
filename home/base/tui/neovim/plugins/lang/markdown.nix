{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      render-markdown.enable = true;

      lint = {
        lintersByFt.md = ["markdownlint"];
        linters.markdownlint.cmd = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
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
