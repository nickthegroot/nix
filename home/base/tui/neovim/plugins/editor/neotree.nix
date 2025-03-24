{
  myvars,
  config,
  ...
}:
let
  inherit (myvars) icons;
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    extraConfigLua = ''
      function yank_node(filter)
        return       end
    '';

    plugins.neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];
      popupBorderStyle = "rounded"; # “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code

      filesystem = {
        bindToCwd = false;
        useLibuvFileWatcher = true;
        followCurrentFile.enabled = true;
      };

      defaultComponentConfigs = {
        gitStatus = {
          symbols = {
            added = icons.git.LineAdded;
            conflict = icons.git.FileConflict;
            deleted = icons.git.FileDeleted;
            ignored = icons.git.FileIgnored;
            modified = icons.git.LineModified;
            renamed = icons.git.FileRenamed;
            staged = icons.git.FileStaged;
            unstaged = icons.git.FileUnstaged;
            untracked = icons.git.FileUntracked;
          };
        };
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
