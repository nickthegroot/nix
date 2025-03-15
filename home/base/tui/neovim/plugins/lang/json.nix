{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          json = [ "prettierd" ];
          jsonc = [ "prettierd" ];
        };

        formatters.prettierd = {
          command = "${pkgs.prettierd}/bin/prettierd";
        };
      };

      lsp.servers = {
        jsonls.enable = true;
      };
    };
  };
}
