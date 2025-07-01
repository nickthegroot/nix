{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      on_last_window_closed = "quit_app";

      ui_font_family = "JetBrainsMono Nerd Font";
      buffer_font_family = "JetBrainsMono Nerd Font";

      relative_line_numbers = true;
      vim_mode = true;

      tab_bar.show = true;
      scrollbar.show = "never";
      tabs.show_diagnostics = "errors";
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      centered_layout = {
        left_padding = 0.15;
        right_padding = 0.15;
      };
      git_panel.dock = "right";
      file_finder.modal_width = "medium";
      project_panel = {
        button = true;
        dock = "right";
        git_status = true;
      };
      outline_panel.dock = "right";
      collaboration_panel.dock = "left";
      notification_panel.dock = "left";
      chat_panel.dock = "left";

      assistant = {
        default_model = {
          provider = "copilot_chat";
          model = "claude-3-7-sonnet";
        };
        version = "2";
      };

      inlay_hints.enabled = true;
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
          format_on_save = {
            language_server = {
              name = "ruff";
            };
          };
          formatter = {
            language_server = {
              name = "ruff";
            };
          };
          language_servers = [
            "pyright"
            "ruff"
          ];
        };
      };
      file_types = {
        Dockerfile = [
          "Dockerfile"
          "Dockerfile.*"
        ];
        JSON = [
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
        {
          bindings = {
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-l" = "workspace::ActivatePaneRight";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-j" = "workspace::ActivatePaneDown";
          };
        }
        {
          context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
          bindings = {
            "${leader} g h d" = "editor::ToggleSelectedDiffHunks";
            "${leader} g s" = "git_panel::ToggleFocus";
            "${leader} t i" = "editor::ToggleInlayHints";
            "${leader} t w" = "editor::ToggleSoftWrap";
            "${leader} c z" = "workspace::ToggleCenteredLayout";
            "${leader} m p" = "markdown::OpenPreview";
            "${leader} m P" = "markdown::OpenPreviewToTheSide";
            "${leader} f p" = "projects::OpenRecent";
            "${leader} s w" = "pane::DeploySearch";
            "${leader} a a" = "agent::Chat";
            "${leader} a c" = "agent::NewThread";
          };
        }
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "${leader} c a" = "editor::ToggleCodeActions";
            "${leader} ." = "editor::ToggleCodeActions";
            "${leader} c r" = "editor::Rename";
            "g d" = "editor::GoToDefinition";
            "g D" = "editor::GoToDefinitionSplit";
            "g i" = "editor::GoToImplementation";
            "g I" = "editor::GoToImplementationSplit";
            "g t" = "editor::GoToTypeDefinition";
            "g T" = "editor::GoToTypeDefinitionSplit";
            "g r" = "editor::FindAllReferences";
            "] d" = "editor::GoToDiagnostic";
            "[ d" = "editor::GoToPreviousDiagnostic";
            "] e" = "editor::GoToDiagnostic";
            "[ e" = "editor::GoToPreviousDiagnostic";
            "s s" = "outline::Toggle";
            "s S" = "project_symbols::Toggle";
            "${leader} x x" = "diagnostics::Deploy";
            "] h" = "editor::GoToHunk";
            "[ h" = "editor::GoToPreviousHunk";
            "shift-h" = "pane::ActivatePreviousItem";
            "shift-l" = "pane::ActivateNextItem";
            "shift-q" = "pane::CloseActiveItem";
            "ctrl-q" = "pane::CloseActiveItem";
            "${leader} b d" = "pane::CloseActiveItem";
            "${leader} b o" = "pane::CloseInactiveItems";
            "ctrl-s" = "workspace::Save";
            "${leader} space" = "file_finder::Toggle";
            "${leader} /" = "pane::DeploySearch";
            "${leader} e" = "pane::RevealInProjectPanel";
          };
        }
        {
          context = "EmptyPane || SharedScreen";
          bindings = {
            "${leader} space" = "file_finder::Toggle";
            "${leader} f p" = "projects::OpenRecent";
          };
        }
        {
          context = "Editor && vim_mode == visual && !VimWaiting && !menu";
          bindings = {
            "g c" = "editor::ToggleComments";
          };
        }
        {
          context = "ProjectPanel && not_editing";
          bindings = {
            "a" = "project_panel::NewFile";
            "A" = "project_panel::NewDirectory";
            "r" = "project_panel::Rename";
            "d" = "project_panel::Delete";
            "x" = "project_panel::Cut";
            "c" = "project_panel::Copy";
            "p" = "project_panel::Paste";
            "q" = "workspace::ToggleRightDock";
            "${leader} e" = "workspace::ToggleRightDock";
          };
        }
      ];
  };
}
