{
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
        settings.sources = {
          providers = {
            copilot = {
              async = true;
              module = "blink-cmp-copilot";
              name = "copilot";
              score_offset = 100;
            };
          };

          default = ["copilot"];
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
