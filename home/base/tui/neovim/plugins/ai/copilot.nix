{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enabled = false;
            autoTrigger = true;
            keymap = {
              accept = false;
            };
          };
          panel.enabled = false;
        };
      };

      blink-cmp-copilot.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
          sources = {
            default = ["copilot"];
            providers = {
              copilot = {
                async = true;
                module = "blink-cmp-copilot";
                name = "copilot";
                score_offset = 100;

                transform_items = mkRaw ''
                  function(_, items)
                    local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                    local kind_idx = #CompletionItemKind + 1
                    CompletionItemKind[kind_idx] = "Copilot"
                    for _, item in ipairs(items) do
                      item.kind = kind_idx
                    end
                    return items
                  end
                '';
              };
            };
          };

          appearance.kind_icons = {
            Copilot = "";
          };
        };
      };

      # which-key.settings.spec = [
      #   {
      #     __unkeyed-1 = "<leader>a";
      #     mode = "n";
      #     icon = "󰚩";
      #     group = "+ai";
      #   }
      # ];
    };
  };
}
