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

      lsp.servers = {
        rust_analyzer = {
          enable = true;
          installCargo = false; # handled per-project
          installRustc = false; # handled per-project
          installRustfmt = false; # handled through conform-nvim
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
  };
}
