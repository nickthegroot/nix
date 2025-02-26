{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings = {
        formatters_by_ft = {
          graphql = ["prettierd"];
        };

        formatters.prettierd = {
          command = "${pkgs.prettierd}/bin/prettierd";
        };
      };

      # Dependent on https://github.com/NixOS/nixpkgs/pull/384397
      # lsp.servers = {
      #   graphql.enable = true;
      # };
    };
  };
}
