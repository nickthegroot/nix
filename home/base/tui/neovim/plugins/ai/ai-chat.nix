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
      sidekick = {
        enable = true;
        settings = {
          cli.mux = {
            backend = "tmux";
            enabled = true;
          };
        };
      };

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
        options.desc = "Goto/Apply Next Edit Suggestion";
      }
      {
        key = "<leader>aa";
        action = mkRaw ''function() require("sidekick.cli").toggle() end'';
        options.desc = "Sidekick Toggle CLI";
      }
      {
        key = "<leader>as";
        action = mkRaw ''function() require("sidekick.cli").select() end'';
        options = {
          desc = "Select CLI";
        };
      }
      {
        key = "<leader>ad";
        action = mkRaw ''function() require("sidekick.cli").close() end'';
        options = {
          desc = "Detach a CLI Session";
        };
      }
      {
        mode = [
          "x"
          "n"
        ];
        key = "<leader>at";
        action = mkRaw ''function() require("sidekick.cli").send({ msg = "{this}" }) end'';
        options = {
          desc = "Send This";
        };
      }
      {
        key = "<leader>af";
        action = mkRaw ''function() require("sidekick.cli").send({ msg = "{file}" }) end'';
        options = {
          desc = "Send File";
        };
      }
      {
        mode = [ "x" ];
        key = "<leader>av";
        action = mkRaw ''function() require("sidekick.cli").send({ msg = "{selection}" }) end'';
        options = {
          desc = "Send Visual Selection";
        };
      }
      {
        mode = [
          "x"
          "n"
        ];
        key = "<leader>ap";
        action = mkRaw ''function() require("sidekick.cli").prompt() end'';
        options = {
          desc = "Sidekick Select Prompt";
        };
      }
    ];
  };
}
