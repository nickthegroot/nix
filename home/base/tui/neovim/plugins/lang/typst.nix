{ pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft.typ = [ "typstyle" ];
        formatters.typstyle.command = "${pkgs.typstyle}/bin/typstyle";
      };
    };

    lsp.servers.tinymist.enable = true;
  };
}
