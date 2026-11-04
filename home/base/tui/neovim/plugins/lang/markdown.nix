{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      render-markdown = {
        enable = true;
        settings.file_types = [
          "markdown"
          "codecompanion"
        ];
      };

      lint = {
        lintersByFt.md = [ "eslint_d" ];
        linters.eslint_d.cmd = "${pkgs.eslint_d}/bin/eslint_d";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>um";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options = {
          silent = true;
          desc = "Toggle markdown preview";
        };
      }
    ];

    # Markdown toggles for blockquotes, bullet lists, and numbered lists on the current or selected lines.
    autoCmd = [
      {
        event = "FileType";
        pattern = "markdown";
        callback.__raw = ''
          function()
            local function selected_range()
              local first = vim.fn.line("v")
              local last = vim.fn.line(".")
              if first > last then
                first, last = last, first
              end
              return first, last
            end

            local function all_lines_match(lines, pattern)
              for _, line in ipairs(lines) do
                if line:match("%S") and not line:match(pattern) then
                  return false
                end
              end
              return true
            end

            local function transform_selection(transform)
              local first, last = selected_range()
              if vim.fn.mode():match("[vV\22]") then
                vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
              end

              local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)
              transform(lines)
              vim.api.nvim_buf_set_lines(0, first - 1, last, false, lines)
              vim.api.nvim_win_set_cursor(0, { first, 0 })
            end

            local function toggle_blockquote()
              transform_selection(function(lines)
                local all_quoted = all_lines_match(lines, "^%s*>")
                for i, line in ipairs(lines) do
                  if all_quoted then
                    lines[i] = line:gsub("^(%s*)> ?", "%1", 1)
                  elseif line:match("^%s*$") then
                    lines[i] = ">"
                  else
                    lines[i] = "> " .. line
                  end
                end
              end)
            end

            local function toggle_bullet_list()
              transform_selection(function(lines)
                local all_bulleted = all_lines_match(lines, "^%s*[-*+]%s")
                for i, line in ipairs(lines) do
                  if all_bulleted then
                    lines[i] = line:gsub("^(%s*)[-*+]%s", "%1", 1)
                  elseif line:match("%S") then
                    lines[i] = "- " .. line
                  end
                end
              end)
            end

            local function toggle_numbered_list()
              transform_selection(function(lines)
                local all_numbered = all_lines_match(lines, "^%s*%d+[.)]%s")
                local number = 0
                for i, line in ipairs(lines) do
                  if all_numbered then
                    lines[i] = line:gsub("^(%s*)%d+[.)]%s", "%1", 1)
                  elseif line:match("%S") then
                    number = number + 1
                    lines[i] = number .. ". " .. line
                  end
                end
              end)
            end

            vim.keymap.set(
              { "n", "x" },
              "<leader>gcq",
              toggle_blockquote,
              { buffer = true, desc = "Toggle blockquote" }
            )
            vim.keymap.set(
              { "n", "x" },
              "<leader>gcb",
              toggle_bullet_list,
              { buffer = true, desc = "Toggle bullet list" }
            )
            vim.keymap.set(
              { "n", "x" },
              "<leader>gcn",
              toggle_numbered_list,
              { buffer = true, desc = "Toggle numbered list" }
            )
          end
        '';
      }
    ];
  };
}
