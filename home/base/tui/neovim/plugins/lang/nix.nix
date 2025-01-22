{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      nix.enable = true;
      hmts.enable = true;
      nix-develop.enable = true;

      conform-nvim.settings = {
        formatters_by_ft = {
          nix = ["alejandra"];
        };

        formatters = {
          alejandra = {
            command = "${pkgs.alejandra}/bin/alejandra";
          };
        };
      };

      lint = {
        lintersByFt = {
          nix = ["statix"];
        };

        linters = {
          statix = {
            cmd = "${pkgs.statix}/bin/statix";
          };
        };
      };

      lsp.servers.nixd = {
        enable = true;
      };
    };

    extraConfigVim = ''
      au BufRead,BufNewFile flake.lock setf json
    '';
  };
}
