{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins = {
      lspconfig.enable = true; # default configs
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
        action = mkRaw "function() vim.lsp.buf.hover() end";
        options.desc = "Hover";
      }
      {
        mode = "n";
        key = "T";
        action = mkRaw "function() vim.diagnostic.open_float() end";
        options.desc = "Hover Diagnostics";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ca";
        action = mkRaw "function() vim.lsp.buf.code_action() end";
        options.desc = "Code action";
      }
      {
        mode = "n";
        key = "<leader>cr";
        action = mkRaw "function() vim.lsp.buf.rename() end";
        options.desc = "Rename Symbol";
      }
      {
        mode = "n";
        key = "<leader>cR";
        action = mkRaw "function() Snacks.rename.rename_file() end";
        options.desc = "Rename File";
      }
      {
        mode = "n";
        key = "gd";
        action = mkRaw "function() Snacks.picker.lsp_definitions() end";
        options.desc = "Goto Definition";
      }
      {
        mode = "n";
        key = "gr";
        action = mkRaw "function() Snacks.picker.lsp_references() end";
        options.desc = "Goto References";
      }
    ];
  };
}
