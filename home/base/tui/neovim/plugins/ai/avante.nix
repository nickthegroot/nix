{
  programs.nixvim = {
    plugins = {
      avante = {
        enable = true;
        settings = {
          provider = "copilot";
          behaviour = {
            auto_suggestions = false;
            auto_set_highlight_group = true;
            auto_set_keymaps = true;
            auto_apply_diff_after_generation = false;
            support_paste_from_clipboard = false;
          };
          hints.enabled = false;
          mappings = {
            diff = {
              ours = "co";
              theirs = "ct";
              all_theirs = "ca";
              both = "cb";
              cursor = "cc";
              next = "]x";
              prev = "[x";
            };
            submit = {
              normal = "<CR>";
              insert = "<C-s>";
            };
            sidebar = {
              apply_all = "A";
              apply_cursor = "a";
              switch_windows = "<Tab>";
              reverse_switch_windows = "<S-Tab>";
            };
          };
          file_selector = {
            provider = "fzf";
            provider_opts = {};
          };
        };
      };

      markdown-preview.settings = {
        filetypes = ["Avante"];
      };

      blink-cmp.settings = {
        sources = {
          default = ["avante_commands" "avante_files" "avante_mentions"];
          providers = {
            avante_commands = {
              name = "avante_commands";
              module = "blink.compat.source";
              score_offset = 90;
              opts = {};
            };
            avante_files = {
              name = "avante_files";
              module = "blink.compat.source";
              score_offset = 100;
              opts = {};
            };
            avante_mentions = {
              name = "avante_mentions";
              module = "blink.compat.source";
              score_offset = 1000;
              opts = {};
            };
          };
        };
      };

      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>a";
          mode = "n";
          icon = "󰚩";
          group = "+ai";
        }
      ];
    };
  };
}
