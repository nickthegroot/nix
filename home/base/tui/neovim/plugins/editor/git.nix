{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        lazygit = { };
      };
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
