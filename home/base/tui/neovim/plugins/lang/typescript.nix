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

      lint = {
        lintersByFt = {
          javascript = [ "eslint_d" ];
          javascriptreact = [ "eslint_d" ];
          typescript = [ "eslint_d" ];
          typescriptreact = [ "eslint_d" ];
        };

        linters.eslint_d.cmd = "${pkgs.eslint_d}/bin/eslint_d";
      };

      ts-autotag.enable = true;
    };

    lsp.servers = {
      tsgo = {
        enable = true;
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
