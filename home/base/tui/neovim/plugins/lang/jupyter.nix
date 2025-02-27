{pkgs, ...}: {
  home.packages = with pkgs; [
    python312Packages.jupytext # nixvim one doesn't activate correctly
  ];

  programs.nixvim = {
    plugins = {
      image = {
        enable = true;
        backend = "kitty";
        maxWidth = 100;
        maxHeight = 12;
        maxHeightWindowPercentage = 9999;
        maxWidthWindowPercentage = 9999;
        windowOverlapClearEnabled = true;
      };
      molten = {
        enable = true;
        settings = {
          # https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md
          image_provider = "image.nvim";
          output_win_max_height = 20;
          wrap_output = true;
        };
      };
      quarto = {
        enable = true;
        settings = {
          lspFeatures = {
            languages = ["python"];
            chunks = "all";
            diagnostics = {
              enabled = true;
              triggers = ["BufWritePost"];
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
        python3Dependencies = p: []; # see home.packages
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
        key = "<C-o>";
        action = ":noautocmd MoltenEnterOutput<CR>";
        options = {
          silent = true;
          desc = "Enter output";
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
  };
}
