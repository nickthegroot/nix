{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          css = [ "prettierd" ];
        };

        formatters.prettierd = {
          command = "${pkgs.prettierd}/bin/prettierd";
        };
      };
    };

    lsp.servers = {
      cssls.enable = true;
      tailwindcss.enable = true;
    };
  };
}
