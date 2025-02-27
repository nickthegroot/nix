{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      markdown-preview = {
        enable = true;
        settings.filetypes = ["markdown"];
      };

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
