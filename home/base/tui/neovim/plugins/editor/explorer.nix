{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        explorer = { };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = mkRaw ''function() Snacks.explorer() end'';
        options.desc = "File Explorer";
      }
    ];
  };
}
