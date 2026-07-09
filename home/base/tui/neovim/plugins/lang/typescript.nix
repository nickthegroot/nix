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
        package = pkgs-unstable.typescript-go;
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
