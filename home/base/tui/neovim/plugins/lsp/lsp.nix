{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim = {
    plugins = {
      lsp-signature.enable = true;

      lsp = {
        enable = true;
        servers.typos_lsp.enable = true;
        keymaps.lspBuf = {
          "<c-k>" = "signature_help";
          "gi" = "implementation";
        };
      };
      lint.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>LspInfo<cr>";
        options.desc = "Lsp Info";
      }
      {
        mode = "n";
        key = "K";
        action = mkRaw "function() return vim.lsp.buf.hover() end";
        options.desc = "Hover";
      }
      {
        mode = ["n" "v"];
        key = "<leader>ca";
        action = mkRaw "vim.lsp.buf.code_action";
        options.desc = "Code Action";
      }
      {
        mode = "n";
        key = "<leader>cr";
        action = mkRaw "vim.lsp.buf.rename";
        options.desc = "Code Action";
      }
    ];
  };
}
