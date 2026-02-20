{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      hmts.enable = true;

      conform-nvim.settings = {
        formatters_by_ft.nix = [ "nixfmt" ];
        formatters = {
          nixfmt.command = "${pkgs.nixfmt}/bin/nixfmt";
        };
      };

      lint = {
        lintersByFt.nix = [ "statix" ];

        linters = {
          statix.cmd = "${pkgs.statix}/bin/statix";
        };
      };
    };

    lsp.servers.nixd.enable = true;

    extraConfigVim = ''
      au BufRead,BufNewFile flake.lock setf json
    '';
  };
}
