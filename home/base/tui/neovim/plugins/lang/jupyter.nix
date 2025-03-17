{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python312Packages.jupytext # nixvim one doesn't activate correctly
  ];

  programs.nixvim = {
    plugins = {
      image = {
        enable = true;
        backend = "kitty";
        maxHeightWindowPercentage = 50;
        maxWidthWindowPercentage = 75;
        windowOverlapClearEnabled = true;
        editorOnlyRenderWhenFocused = false;
        tmuxShowOnlyInActiveWindow = true;
      };
      molten = {
        enable = true;
        settings = {
          # https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md
          image_provider = "image.nvim";
          wrap_output = true;
        };
      };
      quarto = {
        enable = true;
        settings = {
          lspFeatures = {
            languages = [ "python" ];
            chunks = "all";
            diagnostics = {
              enabled = true;
              triggers = [ "BufWritePost" ];
            };
            completion = {
              enabled = true;
            };
          };
          codeRunner = {
            enabled = true;
            default_method = "molten";
          };
        };
      };
      jupytext = {
        enable = true;
        python3Dependencies = p: [ ]; # see home.packages
        settings = {
          style = "markdown";
          output_extension = "md";
          force_ft = "markdown";
        };
      };

      lsp.servers = {
        pyright = {
          extraOptions.settings = {
            python.analysis = {
              # Ignore unused expressions: often mistaken in ipynb contexts
              diagnosticSeverityOverrides.reportUnusedExpression = "none";
            };
          };
        };
      };

      treesitter-textobjects = {
        select = {
          keymaps = {
            "ic" = "@code_cell.inner";
            "ac" = "@code_cell.outer";
          };
        };
        move = {
          gotoNextStart = {
            "]c" = "@code_cell.inner";
          };
          gotoNextEnd = {
            "]C" = "@code_cell.outer";
          };
          gotoPreviousStart = {
            "[c" = "@code_cell.inner";
          };
          gotoPreviousEnd = {
            "[C" = "@code_cell.outer";
          };
        };
      };

      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>r";
          mode = "n";
          icon = "󰠮";
          group = "+repl";
        }
      ];
    };

    keymaps = [
      {
        mode = [
          "n"
        ];
        key = "<leader>ri";
        action = ":MoltenInit<CR>";
        options = {
          silent = true;
          desc = "Initialize molten kernel";
        };
      }
      {
        mode = [
          "n"
        ];
        key = "<leader>re";
        action = ":MoltenEvaluateOperator<CR>";
        options = {
          silent = true;
          desc = "Run operator selection";
        };
      }
      {
        mode = [
          "n"
        ];
        key = "<leader>rl";
        action = ":MoltenEvaluateLine<CR>";
        options = {
          silent = true;
          desc = "Run line";
        };
      }
      {
        mode = [
          "v"
        ];
        key = "<leader>r";
        action = ":<C-u>MoltenEvaluateVisual<CR>gv";
        options = {
          silent = true;
          desc = "Run visual selection";
        };
      }
      {
        mode = [
          "n"
        ];
        key = "<leader>ro";
        action = ":noautocmd MoltenEnterOutput<CR>";
        options = {
          silent = true;
          desc = "Enter output";
        };
      }
      {
        mode = [
          "n"
        ];
        key = "<leader>rO";
        action = ":noautocmd MoltenHideOutput<CR>";
        options = {
          silent = true;
          desc = "Hide output";
        };
      }

      # MARK: Quarto
      {
        mode = [
          "n"
        ];
        key = "<leader>rr";
        action = ":lua require(\"quarto.runner\").run_cell()<CR>";
        options = {
          silent = true;
          desc = "run cell";
        };
      }
      {
        mode = [
          "n"
        ];
        key = "<leader>ra";
        action = ":lua require(\"quarto.runner\").run_above()<CR>";
        options = {
          silent = true;
          desc = "run cell and above";
        };
      }
      {
        mode = [
          "n"
        ];
        key = "<leader>rA";
        action = ":lua require(\"quarto.runner\").run_all()<CR>";
        options = {
          silent = true;
          desc = "run all cells";
        };
      }
    ];

    extraFiles = {
      "ftplugin/markdown.lua".text = ''
        require("quarto").activate()
      '';
      "after/queries/markdown/textobjects.scm".text = ''
        ;; extends

        (fenced_code_block (code_fence_content) @code_cell.inner) @code_cell.outer
      '';
    };

    extraConfigLua = ''
      local default_notebook = [[
        {
          "cells": [
           {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
              ""
            ]
           }
          ],
          "metadata": {
           "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
           },
           "language_info": {
            "codemirror_mode": {
              "name": "ipython"
            },
            "file_extension": ".py",
            "mimetype": "text/x-python",
            "name": "python",
            "nbconvert_exporter": "python",
            "pygments_lexer": "ipython3"
           }
          },
          "nbformat": 4,
          "nbformat_minor": 5
        }
      ]]

      local function new_notebook(filename)
        local path = filename .. ".ipynb"
        local file = io.open(path, "w")
        if file then
          file:write(default_notebook)
          file:close()
          vim.cmd("edit " .. path)
        else
          print("Error: Could not open new notebook file for writing.")
        end
      end

      vim.api.nvim_create_user_command('NewNotebook', function(opts)
        new_notebook(opts.args)
      end, {
        nargs = 1,
        complete = 'file'
      })
    '';
  };
}
