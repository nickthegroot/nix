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
        svelte.enable = true;

        biome = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
            "svelte"
          ];
        };

        vtsls = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
            "svelte"
          ];

          settings = {
            complete_function_calls = true;
            vtsls = {
              autoUseWorkspaceTsdk = true;
              experimental = {
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
