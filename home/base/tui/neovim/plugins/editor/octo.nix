{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins.octo = {
      enable = true;
      settings = {
        picker = "snacks";
        enable_builtin = true;
        mappings_disable_default = true;
      };
    };

    keymaps = [
      # comments
      {
        mode = "n";
        key = "<leader>gcO";
        action = mkRaw ''function() require("octo.mappings").add_comment() end'';
        options = {
          desc = "add comment";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gco";
        action = mkRaw ''function() require("octo.mappings").add_reply() end'';
        options = {
          desc = "add reply";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcd";
        action = mkRaw ''function() require("octo.mappings").delete_comment() end'';
        options = {
          desc = "delete comment";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcs";
        action = mkRaw ''function() require("octo.mappings").add_suggestion() end'';
        options = {
          desc = "add suggestion to comment";
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>gca";
        action = mkRaw ''function() require("octo.mappings").add_review_comment() end'';
        options = {
          desc = "add review comment";
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>gcA";
        action = mkRaw ''function() require("octo.mappings").add_review_suggestion() end'';
        options = {
          desc = "add review suggestion";
          silent = true;
        };
      }

      # reactions
      {
        mode = "n";
        key = "<leader>gcrp";
        action = mkRaw ''function() require("octo.mappings").react_hooray() end'';
        options = {
          desc = "add/remove 🎉 reaction";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcrh";
        action = mkRaw ''function() require("octo.mappings").react_heart() end'';
        options = {
          desc = "add/remove ❤️ reaction";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcre";
        action = mkRaw ''function() require("octo.mappings").react_eyes() end'';
        options = {
          desc = "add/remove 👀 reaction";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcr+";
        action = mkRaw ''function() require("octo.mappings").react_thumbs_up() end'';
        options = {
          desc = "add/remove 👍 reaction";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcr-";
        action = mkRaw ''function() require("octo.mappings").react_thumbs_down() end'';
        options = {
          desc = "add/remove 👎 reaction";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcrr";
        action = mkRaw ''function() require("octo.mappings").react_rocket() end'';
        options = {
          desc = "add/remove 🚀 reaction";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcrl";
        action = mkRaw ''function() require("octo.mappings").react_laugh() end'';
        options = {
          desc = "add/remove 😄 reaction";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gcrc";
        action = mkRaw ''function() require("octo.mappings").react_confused() end'';
        options = {
          desc = "add/remove 😕 reaction";
          silent = true;
        };
      }

      # review panel
      {
        mode = "n";
        key = "<leader>E";
        action = mkRaw ''function() require("octo.mappings").focus_files() end'';
        options = {
          desc = "move focus to changed file panel";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>te";
        action = mkRaw ''function() require("octo.mappings").toggle_files() end'';
        options = {
          desc = "hide/show changed files panel";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader><CR>";
        action = mkRaw ''
          function()
                    require("octo.mappings").toggle_viewed()
                    require("octo.mappings").select_next_unviewed_entry()
                  end'';
        options = {
          desc = "toggle viewed and go to next unviewed file";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<cr>";
        action = mkRaw ''
          function()
            if vim.bo.filetype == "octo_panel" then
              require("octo.mappings").select_entry()
            end
          end'';
        options = {
          silent = true;
        };
      }
    ];

    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>gc";
        mode = "n";
        group = "+comments";
      }
      {
        __unkeyed-1 = "<leader>gcr";
        mode = "n";
        group = "+reactions";
      }
    ];
  };
}
