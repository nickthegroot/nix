{ pkgs, pkgs-unstable, ... }:
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

      ts-autotag.enable = true;
    };

    lsp.servers = {
      tsgo = {
        enable = true;
        package = pkgs-unstable.typescript-go.overrideAttrs (
          finalAttrs: prevAttrs: {
            # Use fork until non-relative import code actions work
            # (Issue claims to have fixed, but still seeing it. Fix in fork is AI generated and I don't have enough go/codebase context to submit for PR.)
            src = pkgs-unstable.fetchFromGitHub {
              owner = "nickthegroot";
              repo = "typescript-go";
              rev = "b93f2737a50410d330ad50e2e1f2d5ac5b771ecd";
              hash = "sha256-nUviiG2r52ICs4CCYE/r6FXtEUsGNPDt5MNwbazpiD4=";
            };
            vendorHash = "sha256-q6dMb2ab4uZ3GTrcA7v2JzfmOM+ZzBcJN6gKOpLfM/k=";

            version = "7.1.0-dev";
          }
        );
        config.settings = {
          "js/ts.preferences.importModuleSpecifier" = "non-relative";
        };
      };
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
  };
}
