{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          javascript = ["prettierd"];
          javascriptreact = ["prettierd"];
          typescript = ["prettierd"];
          typescriptreact = ["prettierd"];
          svelte = ["prettierd"];
        };

        formatters.prettierd = {
          command = "${pkgs.prettierd}/bin/prettierd";
        };
      };

      lsp.servers = {
        vtsls = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "javascript.jsx"
            "typescript"
            "typescriptreact"
            "typescript.tsx"
          ];

          settings = {
            complete_function_calls = true;
            vtsls = {
              enableMoveToFileCodeAction = true;
              autoUseWorkspaceTsdk = true;
              experimental = {
                maxInlayHintLength = 30;
                completion = {
                  enableServerSideFuzzyMatch = true;
                };
              };
            };

            typescript = {
              updateImportsOnFileMove.enabled = "always";
              preferences.importModuleSpecifier = "non-relative";
              suggest = {
                completeFunctionCalls = true;
              };

              inlayHints = {
                enumMemberValues.enabled = true;
                functionLikeReturnTypes.enabled = true;
                parameterNames.enabled = "literals";
                parameterTypes.enabled = true;
                propertyDeclarationTypes.enabled = true;
                variableType.enabled = false;
              };
            };
          };
        };
      };

      ts-autotag.enable = true;
    };
  };
}
