{ config, ... }:
let
  inherit (config.lib.nixvim) mkRaw;
in
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        dashboard = {
          width = 100;
          sections = [
            { section = "header"; }
            {
              icon = " ";
              title = "Keymaps";
              section = "keys";
              indent = 3;
              padding = 1;
            }
            {
              icon = " ";
              desc = "Browse Repo";
              padding = 1;
              key = "b";
              action = ":lua Snacks.gitbrowse()";
            }
            (mkRaw ''
              function()
                local in_git = Snacks.git.get_root() ~= nil
                local cmds = {
                  {
                    title = "Notifications",
                    cmd = "gh notify -s -n5",
                    action = function()
                      vim.ui.open("https://github.com/notifications")
                    end,
                    key = "a",
                    icon = " ",
                    height = 5,
                    enabled = true,
                  },
                  {
                    icon = " ",
                    title = "Open PRs",
                    cmd = "gh pr list -S \"review-requested:@me\" -L 3",
                    key = "p",
                    action = function()
                      vim.fn.jobstart("gh pr list -S \"review-requested:@me\" --web", { detach = true })
                    end,
                    height = 7,
                  },
                  {
                    icon = " ",
                    title = "Git Status",
                    cmd = "git --no-pager diff --stat -B -M -C",
                    height = 10,
                  },
                }
                return vim.tbl_map(function(cmd)
                  return vim.tbl_extend("force", {
                    section = "terminal",
                    enabled = in_git,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                  }, cmd)
                end, cmds)
              end
            '')
          ];
          preset = {
            # https://github.com/0xShone/divergence-meter-aa
            header = ''
              　　∩.　　　∩.　　　∩.　　　∩.　　　∩.　　　∩.　　　∩.　　　∩.
              　ノ×乂   ノ×乂   ノ×乂 　ノ×乂 　ノ×乂　 ノ×乂　 ノ×乂　 ノ×乂
              　|0┓爻|　|０爻|　|┏┓爻|　|┃┃爻|　|┏┓爻|　|┏┓爻|　|┏┓爻|　|┏┓爻|
              　|○┃爻|　|爻爻|　|┃┃爻|　|┗╋爻|　|┣┫爻|　|┗┓爻|　|┗┫爻|　|┣┓爻|
              　|0┃圭|　| * #|　|┗┛圭|　|/┃圭|　|┗┛圭|　|┗┛圭|　|┗┛圭|　|┗┛圭|
              　|圭圭|　|圭圭|　|圭圭|　|圭圭|　|圭圭|　|圭圭|　|圭圭|　|圭圭|
              /|卅卅|廾|卅卅|廾|卅卅|廾|卅卅|廾|卅卅|廾|卅卅|廾|卅卅|廾|卅卅|且¯/|
              |￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣||
              |                   -Welcome back, nickthegroot-                   ||
              |＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿|/
            '';
            keys = [
              {
                icon = " ";
                key = "f";
                desc = "Find File";
                action = ":lua Snacks.dashboard.pick('files')";
              }
              {
                icon = " ";
                key = "n";
                desc = "New File";
                action = ":ene | startinsert";
              }
              {
                icon = " ";
                key = "g";
                desc = "Find Text";
                action = ":lua Snacks.dashboard.pick('live_grep')";
              }
              {
                icon = " ";
                key = "r";
                desc = "Recent Files";
                action = ":lua Snacks.dashboard.pick('oldfiles')";
              }
              {
                icon = " ";
                key = "s";
                desc = "Restore Session";
                section = "session";
              }
              {
                icon = " ";
                key = "q";
                desc = "Quit";
                action = ":qa";
              }
            ];
          };
        };
      };
    };
  };
}
