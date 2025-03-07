{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings.gitbrowse = {
        enable = true;
        what = "permalink";
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>go";
        action = mkRaw ''function() Snacks.gitbrowse.open() end'';
        options = {
          desc = "Open permalink";
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>gy";
        action = mkRaw ''
          function()
            Snacks.gitbrowse.open({
              open = function(url)
                vim.fn.setreg("+", url, "c")
              end
            })
          end
        '';
        options = {
          desc = "Copy permalink";
        };
      }
    ];
  };
}
