{
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;
      settings = {
        winopts = {
          width = 0.8;
          height = 0.8;
          row = 0.5;
          col = 0.5;
          preview = {
            scrollchars = ["┃" ""];
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>FzfLua files<cr>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>FzfLua live_grep<cr>";
        options.desc = "Search Grep";
      }
      {
        mode = "n";
        key = "<leader>sw";
        action = "<cmd>FzfLua grep_cword<cr>";
        options.desc = "Search current word";
      }
      {
        mode = "n";
        key = "<leader>sW";
        action = "<cmd>FzfLua grep_cWORD<cr>";
        options.desc = "Search current word";
      }
      {
        mode = "v";
        key = "<leader>sw";
        action = "<cmd>FzfLua grep_visual<cr>";
        options.desc = "Search current selection";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>FzfLua diagnostics_document<cr>";
        options.desc = "Document Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>sD";
        action = "<cmd>FzfLua diagnostics_workspace<cr>";
        options.desc = "Workspace Diagnostics";
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>";
        options.desc = "Goto Definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>";
        options.desc = "Goto References";
      }
    ];
  };
}
