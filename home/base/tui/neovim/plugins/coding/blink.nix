{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        sources = {
          default = ["lsp" "path" "buffer"];
          cmdline = [];
        };

        appearance = {
          use_nvim_cmp_as_default = false;
          nerd_font_variant = "mono";

          # Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
          kind_icons = {
            Text = "󰉿";
            Method = "󰊕";
            Function = "󰊕";
            Constructor = "󰒓";

            Field = "󰜢";
            Variable = "󰆦";
            Property = "󰖷";

            Class = "󱡠";
            Interface = "󱡠";
            Struct = "󱡠";
            Module = "󰅩";

            Unit = "󰪚";
            Value = "󰦨";
            Enum = "󰦨";
            EnumMember = "󰦨";

            Keyword = "󰻾";
            Constant = "󰏿";

            Snippet = "󱄽";
            Color = "󰏘";
            File = "󰈔";
            Reference = "󰬲";
            Folder = "󰉋";
            Event = "󱐋";
            Operator = "󰪚";
            TypeParameter = "󰬛";
          };
        };

        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
            };
          };
          menu = {
            draw = {
              treesitter = ["lsp"];
            };
          };
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
          ghost_text = {
            enabled = true;
          };
        };
      };
    };
    blink-compat.enable = true;
  };
}
