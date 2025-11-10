{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    # Sidekick auto-enables a bunch of AI tools (~2GB all-in :0)
    # Disable everything except for copilot
    dependencies = {
      copilot.enable = true;

      claude-code.enable = false;
      gemini.enable = false;
      opencode.enable = false;
    };

    plugins = {
      sidekick.enable = true;

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
        key = "<tab>";
        action = mkRaw ''
          function()
            -- if there is a next edit, jump to it, otherwise apply it if any
            if not require("sidekick").nes_jump_or_apply() then
              return "<Tab>" -- fallback to normal tab
            end
          end
        '';
        options = {
          desc = "Goto/Apply Next Edit Suggestion";
          expr = true;
        };
      }

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
