{
  programs.nixvim = {
    lsp.servers.copilot.enable = true;

    plugins = {
      blink-copilot.enable = true;
      copilot-lua.enable = false; # auto-enabled by blink-copilot, but lsp version already installed
      blink-cmp = {
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
