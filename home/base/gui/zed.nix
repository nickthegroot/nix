{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      on_last_window_closed = "quit_app";

      ui_font_family = "JetBrainsMono Nerd Font";
      buffer_font_family = "JetBrainsMono Nerd Font";

      relative_line_numbers = true;
      vim_mode = true;

      tab_size = 2;
      hard_tabs = false;

      # Visual settings
      tab_bar = {
        show = true;
      };
      tabs = {
        show_diagnostics = "errors";
      };
      scrollbar = {
        show = "never";
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      centered_layout = {
        left_padding = 0.15;
        right_padding = 0.15;
      };

      # Panel layout matching preferences
      project_panel = {
        button = true;
        dock = "left";
        git_status = true;
      };
      outline_panel = {
        dock = "right";
      };
      git_panel = {
        dock = "right";
      };
      collaboration_panel = {
        dock = "left";
      };

      # Search and navigation settings
      search = {
        case_sensitive = false;
        whole_word = false;
        regex = false;
      };
      use_smartcase_search = true;

      # Editor behavior
      autosave = "off";
      format_on_save = "off";
      ensure_final_newline_on_save = true;
      remove_trailing_whitespace_on_save = true;

      # Inlay hints and language features
      inlay_hints = {
        enabled = true;
      };
      languages = {
        TypeScript = {
          inlay_hints = {
            enabled = true;
            show_parameter_hints = false;
            show_other_hints = true;
            show_type_hints = true;
          };
        };
        Python = {
          tab_size = 2;
          format_on_save = "off";
          formatter = {
            language_server = {
              name = "ruff";
            };
          };
        };
        Nix = {
          tab_size = 2;
        };
      };

      file_types = {
        Dockerfile = [
          "Dockerfile"
          "Dockerfile.*"
        ];
        JSONC = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
      };

      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
        "**/out"
        "**/dist"
        "**/.husky"
        "**/.turbo"
        "**/.vscode-test"
        "**/.vscode"
        "**/.next"
        "**/.storybook"
        "**/.tap"
        "**/.nyc_output"
        "**/report"
        "**/node_modules"
      ];

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };

    userKeymaps =
      let
        leader = "space";
      in
      [
        # Windows
        {
          bindings = {
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-j" = "workspace::ActivatePaneDown";
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-l" = "workspace::ActivatePaneRight";
          };
        }

        # Buffers
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "shift-l" = "pane::ActivateNextItem";
            "shift-h" = "pane::ActivatePreviousItem";
          };
        }

        # Code Actions and LSP
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "${leader} c a" = "editor::ToggleCodeActions";
            "${leader} c r" = "editor::Rename";
            "${leader} c f" = "editor::Format";
            "${leader} c o" = "editor::OrganizeImports";
          };
        }

        {
          context = "Editor && vim_mode == visual && !VimWaiting && !menu";
          bindings = {
            "${leader} c a" = "editor::ToggleCodeActions";
            "${leader} c f" = "editor::Format";
          };
        }

        # Toggles
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "${leader} t i" = "editor::ToggleInlayHints";
          };
        }

        # Go To / Navigation
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "g d" = "editor::GoToDefinition";
            "g r" = "editor::FindAllReferences";
          };
        }

        # Diagnostics
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "] d" = "editor::GoToDiagnostic";
            "[ d" = "editor::GoToPreviousDiagnostic";
          };
        }

        # Git
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "] h" = "editor::GoToHunk";
            "[ h" = "editor::GoToPreviousHunk";
          };
        }

        # Comments
        {
          context = "Editor && vim_mode == visual && !VimWaiting && !menu";
          bindings = {
            "g c" = "editor::ToggleComments";
          };
        }

        # Fuzzy Finder
        {
          context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
          bindings = {
            "${leader} ${leader}" = "file_finder::Toggle";
          };
        }

        # File Explorer
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "${leader} e" = "pane::RevealInProjectPanel";
          };
        }

        # Projects
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "${leader} f p" = "projects::OpenRecent";
          };
        }

        # Search
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "${leader} /" = "pane::DeploySearch";
          };
        }

        # Project Panel
        {
          context = "ProjectPanel && not_editing";
          bindings = {
            "a" = "project_panel::NewFile";
            "shift-a" = "project_panel::NewDirectory";
            "r" = "project_panel::Rename";
            "d" = "project_panel::Delete";
            "x" = "project_panel::Cut";
            "c" = "project_panel::Copy";
            "p" = "project_panel::Paste";
            "q" = "workspace::ToggleRightDock";
          };
        }

        # Save
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "ctrl-s" = "workspace::Save";
          };
        }
      ];
  };
}
