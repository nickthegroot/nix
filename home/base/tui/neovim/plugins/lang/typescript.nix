{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          javascript = ["biome"];
          javascriptreact = ["biome"];
          typescript = ["biome"];
          typescriptreact = ["biome"];
          svelte = ["biome"];
        };
      };

      lsp.servers = {
        biome = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "javascript.jsx"
            "typescript"
            "typescriptreact"
            "typescript.tsx"
          ];
        };

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
