{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins = {
      snacks = {
        enable = true;
        settings = {
          lazygit = { };
        };
      };

      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>g";
          mode = "n";
          icon = "";
          group = "+git";
        }
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = mkRaw ''function() Snacks.lazygit() end'';
        options.desc = "Lazygit";
      }
    ];
  };
}
