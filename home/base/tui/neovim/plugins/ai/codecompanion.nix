{
  programs.nixvim = {
    plugins = {
      codecompanion = {
        enable = true;
        settings = {
          strategies = {
            chat.adapter = "copilot";
            inline.adapter = "copilot";
          };
        };
      };

      blink-cmp.settings.sources.per_filetype.codecompanion = [ "codecompanion" ];

      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>a";
          mode = [
            "n"
            "v"
          ];
          icon = "";
          group = "+ai";
        }
      ];
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<C-a>";
        action = "<cmd>CodeCompanionActions<cr>";
        options.desc = "CodeCompanion";
      }

      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>aa";
        action = "<cmd>CodeCompanionChat Toggle<cr>";
        options.desc = "CodeCompanion Chat";
      }

      {
        mode = [
          "v"
        ];
        key = "<leader>ai";
        action = "<cmd>CodeCompanionChat Add<cr>";
        options.desc = "CodeCompanion Add To Chat";
      }
    ];
  };
}
