{ myvars, ... }:
{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          always_divide_middle = true;
          ignore_focus = [ "neo-tree" ];
          globalstatus = true; # have a single statusline at bottom of neovim instead of one for every window
          disabled_filetypes.statusline = [ "snacks_dashboard" ];
          section_separators = {
            left = "";
            right = "";
          };
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_y = [
          ];
          lualine_z = [ ''"${myvars.icons.ui.Time}" .. os.date("%I:%M %p")'' ];
        };
      };
    };
    extraConfigLua = ''
        local ui = {}

        function ui.fg(name)
          local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
          local fg = hl and (hl.fg or hl.foreground)
          return fg and { fg = string.format("#%06x", fg) } or nil
        end

        ---@param opts? {relative: "cwd"|"root", modified_hl: string?}
        function ui.pretty_path(opts)
          opts = vim.tbl_extend("force", {
            relative = "cwd",
            modified_hl = "Constant",
          }, opts or {})

          return function(self)
            local path = vim.fn.expand("%:p") --[[@as string]]

            if path == "" then
              return ""
            end

            local bufname = vim.fn.bufname(vim.fn.bufnr())
            local sep = package.config:sub(1, 1)

            local root = (opts.relative == "root") and vim.fn.getcwd() or vim.fn.fnamemodify(bufname, ":h")
            local cwd = vim.fn.getcwd()

            path = (opts.relative == "cwd" and path:find(cwd, 1, true) == 1) and path:sub(#cwd + 2) or path:sub(#root + 2)

            local parts = vim.split(path, "[\\/]")
            if #parts > 3 then
              parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
            end

            if opts.modified_hl and vim.bo.modified then
              local modified_hl_fg = ui.fg(opts.modified_hl)
              if modified_hl_fg then
                parts[#parts] = string.format("%%#%s#%s%%*", opts.modified_hl, parts[#parts])
              end
            end

            return table.concat(parts, sep)
          end
        end

        require("lualine").setup({
          sections = {
            lualine_c = {
              {
                "diagnostics",
                symbols = {
                  error = "${myvars.icons.diagnostics.Error}",
                  warn  = "${myvars.icons.diagnostics.Warning}",
                  hint  = "${myvars.icons.diagnostics.Hint}",
                  info  = "${myvars.icons.diagnostics.BoldInformation}",
                },
              },
              { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
              { ui.pretty_path() },
            },
            lualine_x = {
              {
                "diff",
                symbols = {
                  added = "${myvars.icons.git.LineAdded}",
                  modified = "${myvars.icons.git.LineModified}",
                  removed= "${myvars.icons.git.LineRemoved}",
                },
              },
            }
          }
      })
    '';
  };
}
