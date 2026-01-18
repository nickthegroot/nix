{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          javascript = [ "prettierd" ];
          javascriptreact = [ "prettierd" ];
          typescript = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          svelte = [ "prettierd" ];
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

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "ts-error-translator.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "dmmulroy";
          repo = "ts-error-translator.nvim";
          rev = "558abff11b9e8f4cefc0de09df780c56841c7a4b";
          hash = "sha256-kjZwfvb0B7GC4dBBSdgC/zRmCUCfCm4H5J+8SFzANJ4=";
        };
      })
    ];
    extraConfigLua = ''
      require("ts-error-translator").setup({ auto_attach = true })
    '';

    # Upstream Issue: https://github.com/NixOS/nixpkgs/issues/478561
    # Temporary Fix: https://github.com/nix-community/nixvim/issues/4152#issuecomment-3748297266
    extraFiles = {
      "queries/ecma/highlights.scm".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nvim-treesitter/nvim-treesitter/d19def46c112c26c17adeef88dd1253cc6d623a1/runtime/queries/ecma/highlights.scm";
        sha256 = "sha256-N4NFR+uqnBYMrYfqvTg4fUcisbQNRLq1TY5x0f7/m54=";
      };
    };

  };
}
