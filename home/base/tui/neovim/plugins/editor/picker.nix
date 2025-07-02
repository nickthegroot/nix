{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        picker = {
          ui_select = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader><space>";
        action = mkRaw ''function() Snacks.picker.smart() end'';
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = mkRaw ''function() Snacks.picker.grep() end'';
        options.desc = "Search Grep";
      }
      {
        mode = "n";
        key = "<leader>sc";
        action = mkRaw ''function() Snacks.picker.git_status() end'';
        options.desc = "Search Changed";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>sw";
        action = mkRaw ''function() Snacks.picker.grep_word() end'';
        options.desc = "Search current selection/word";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action = mkRaw ''function() Snacks.picker.lsp_symbols() end'';
        options.desc = "Search document symbols";
      }
      {
        mode = "n";
        key = "<leader>sS";
        action = mkRaw ''function() Snacks.picker.lsp_workspace_symbols() end'';
        options.desc = "Search workspace symbols";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = mkRaw ''function() Snacks.picker.diagnostics_buffer() end'';
        options.desc = "Document Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>sD";
        action = mkRaw ''function() Snacks.picker.diagnostics() end'';
        options.desc = "Workspace Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>su";
        action = mkRaw ''function() Snacks.picker.undo() end'';
        options.desc = "Undo History";
      }
    ];

    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>g";
        mode = "n";
        icon = "";
        group = "+git";
      }
    ];
  };
}
