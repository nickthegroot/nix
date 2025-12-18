{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      crates = {
        enable = true;
        settings = {
          completion.crates.enabled = true;
          lsp = {
            enabled = true;
            actions = true;
            completion = true;
            hover = true;
          };
        };
      };

      conform-nvim.settings = {
        formatters_by_ft = {
          rust = [ "rustfmt" ];
        };

        formatters = {
          rustfmt = {
            command = "${pkgs.rustfmt}/bin/rustfmt";
          };
        };
      };
    };

    lsp.servers.rust_analyzer.enable = true;
  };
}
