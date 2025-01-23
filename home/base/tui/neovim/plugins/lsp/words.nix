{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        words = {};
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "]]";
        action = mkRaw ''function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight"'';
        options = {
          desc = "Next Reference";
        };
      }
      {
        mode = "n";
        key = "[[";
        action = mkRaw ''function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight"'';
        options = {
          desc = "Prev Reference";
        };
      }
    ];
  };
}
