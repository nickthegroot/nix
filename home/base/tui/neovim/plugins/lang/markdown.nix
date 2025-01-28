{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      markdown-preview = {
        enable = true;
        settings.filetypes = ["markdown"];
      };

      lsp.servers = {
        marksman.enable = true;

        ltex = {
          enable = true;
          filetypes = [
            "markdown"
            "text"
          ];

          settings.completionEnabled = true;

          extraOptions = {
            checkFrequency = "save";
            language = "en-US";
          };
        };
      };

      lint = {
        lintersByFt.md = ["markdownlint"];
        linters.markdownlint.cmd = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options = {
          silent = true;
          desc = "Toggle markdown preview";
        };
      }
    ];
  };
}
