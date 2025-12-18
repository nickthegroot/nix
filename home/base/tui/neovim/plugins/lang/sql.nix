{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft.sql = [ "sqlformatter" ];
        formatters.sqlformatter.command = "${pkgs.sql-formatter}/bin/sql-formatter";
      };
    };

    lsp.servers.postgres_lsp.enable = true;
  };
}
