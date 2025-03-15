{
  programs.nixvim = {
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

      blink-copilot.enable = true;

      blink-cmp = {
        enable = true;
        settings = {
          sources = {
            default = [ "copilot" ];
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
