{
  config,
  pkgs,
  ...
}: let
  # inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim = {
    # Waiting on https://github.com/nix-community/nixvim/issues/2915
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "blink-copilot";
        version = "2025-01-27";
        src = pkgs.fetchFromGitHub {
          owner = "fang2hou";
          repo = "blink-copilot";
          rev = "7e63f20b8e96191e5c87bf96fc35da3547993be2";
          sha256 = "10lm90xa7w3ww94acivshnzkp4q2bfrq9zff2z5amrp3cxlga0rf";
        };
        meta.homepage = "https://github.com/fang2hou/blink-copilot/";
      })
    ];

    plugins = {
      copilot-lua = {
        enable = true;
        settings = {
          suggestion.enabled = false;
          panel.enabled = false;
          filetypes = {
            markdown = true;
            help = true;
          };
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          sources = {
            default = ["copilot"];
            providers = {
              copilot = {
                name = "copilot";
                module = "blink-copilot";
                score_offset = 100;
                async = true;
                opts = {
                  max_completions = 3;
                  max_attempts = 4;
                };
              };
            };
          };

          appearance.kind_icons = {
            Copilot = "";
          };
        };
      };
    };
  };
}
