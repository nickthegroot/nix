{
  config,
  ...
}:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;

      settings = {
        close_if_last_window = true;
        popup_border_style = "rounded"; # “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
        sources = [
          "filesystem"
          "buffers"
          "git_status"
          "document_symbols"
        ];

        filesystem = {
          bind_to_cwd = false;
          use_libuv_file_watcher = true;
          follow_current_file.enabled = true;
        };

        window.mappings =
          let
            yankNode =
              selector:
              mkRaw ''
                function(state)
                  local node = state.tree:get_node()
                  local result = ${selector}
                  vim.fn.setreg('"', result)
                  vim.notify('Copied: ' .. result)
                end
              '';
          in
          {
            "<space>" = "none";
            "l" = "open";
            "h" = "close_node";
            "YY" = {
              command = yankNode ''vim.fn.fnamemodify(node:get_id(), ':.')'';
              desc = "[Y]ank relative path";
            };

            "Ya" = {
              command = yankNode ''node:get_id()'';
              desc = "[Y]ank [a]bsolute path";
            };
            "Yr" = {
              command = yankNode ''vim.fn.fnamemodify(node:get_id(), ':.')'';
              desc = "[Y]ank [r]elative path";
            };
            "Yh" = {
              command = yankNode ''vim.fn.fnamemodify(node:get_id(), ':~')'';
              desc = "[Y]ank path relative to [h]ome";
            };
            "Yf" = {
              command = yankNode ''node.name'';
              desc = "[Y]ank [f]ilename";
            };
            "Yn" = {
              command = yankNode ''vim.fn.fnamemodify(node.name, ':r')'';
              desc = "[Y]ank [n]ame without extension";
            };
            "Ye" = {
              command = yankNode ''vim.fn.fnamemodify(node.name, ':e')'';
              desc = "[Y]ank [e]xtension";
            };
          };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          silent = true;
          desc = "Explorer NeoTree (root dir)";
        };
      }
    ];
  };
}
