{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    lsp.servers.copilot.enable = true;

    opts.autoread = true;

    plugins = {
      opencode.enable = true;
      snacks = {
        enable = true;
        settings = {
          input = { };
          picker = { };
        };
      };

      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>a";
          mode = [
            "n"
            "v"
          ];
          icon = "";
          group = "+ai";
        }
      ];
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>aa";
        action = mkRaw ''function() require("opencode").ask("@this: ", { submit = true }) end'';
        options.desc = "[A]sk Opencode...";
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "<S-C-a>";
        action = mkRaw ''function() require("opencode").toggle() end'';
        options.desc = "Toggle Opencode";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>ax";
        action = mkRaw ''function() require("opencode").select() end'';
        options.desc = "E[x]ecute Opencode action...";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>ai";
        action = mkRaw ''function() return require("opencode").operator("@this ") end'';
        options = {
          desc = "[I]nsert range to Opencode";
          expr = true;
        };
      }
      {
        mode = "n";
        key = "<S-C-u>";
        action = mkRaw ''function() require("opencode").command("session.half.page.up") end'';
        options.desc = "Scroll Opencode up";
      }
      {
        mode = "n";
        key = "<S-C-d>";
        action = mkRaw ''function() require("opencode").command("session.half.page.down") end'';
        options.desc = "Scroll Opencode down";
      }
    ];
  };
}
