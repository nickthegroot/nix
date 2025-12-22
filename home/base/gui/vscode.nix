{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        charliermarsh.ruff
        ms-python.python
        ms-toolsai.jupyter
      ];

      userSettings = {
        # Window behavior
        "window.closeWhenEmpty" = true;

        # Font settings
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";

        # Line numbers and vim
        "editor.lineNumbers" = "relative";
        "vim.useSystemClipboard" = false;

        # Tab settings
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;

        # Visual settings
        "workbench.editor.showTabs" = "multiple";
        "problems.decorations.enabled" = true;
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";
        "editor.guides.indentation" = true;
        "editor.guides.highlightActiveIndentation" = true;

        # Sidebar and panel layout
        "workbench.sideBar.location" = "left";
        "workbench.panel.defaultLocation" = "right";
        "scm.defaultViewMode" = "tree";

        # Search settings
        "search.smartCase" = true;
        "search.useGlobalIgnoreFiles" = true;

        # Editor behavior
        "files.autoSave" = "off";
        "editor.formatOnSave" = true;
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;

        # Inlay hints
        "editor.inlayHints.enabled" = "on";
        "[typescript]" = {
          "editor.inlayHints.enabled" = "on";
        };
        "typescript.inlayHints.parameterNames.enabled" = "none";
        "typescript.inlayHints.variableTypes.enabled" = true;
        "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;

        "github.copilot.nextEditSuggestions.enabled" = true;

        # Language-specific settings
        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
        };

        # File associations
        "files.associations" = {
          "Dockerfile.*" = "dockerfile";
          "*.code-snippets" = "jsonc";
        };

        # File exclusions
        "files.exclude" = {
          "**/.git" = true;
          "**/.svn" = true;
          "**/.hg" = true;
          "**/CVS" = true;
          "**/.DS_Store" = true;
          "**/Thumbs.db" = true;
          "**/.classpath" = true;
          "**/.settings" = true;
        };
        "search.exclude" = {
          "**/out" = true;
          "**/dist" = true;
          "**/.husky" = true;
          "**/.turbo" = true;
          "**/.vscode-test" = true;
          "**/.vscode" = true;
          "**/.next" = true;
          "**/.storybook" = true;
          "**/.tap" = true;
          "**/.nyc_output" = true;
          "**/report" = true;
          "**/node_modules" = true;
        };

        # Telemetry
        "telemetry.telemetryLevel" = "off";

        # Vim extension keybindings (requires VSCode Vim extension)
        "vim.leader" = "<space>";
        "vim.useCtrlKeys" = true;
        "vim.handleKeys" = {
          "<C-k>" = false;
          "<C-j>" = false;
          "<C-h>" = false;
          "<C-l>" = false;
        };
      };

      keybindings = [
        # Window navigation (replacing vim ctrl keys)
        {
          key = "ctrl+k";
          command = "workbench.action.navigateUp";
        }
        {
          key = "ctrl+j";
          command = "workbench.action.navigateDown";
        }
        {
          key = "ctrl+h";
          command = "workbench.action.navigateLeft";
        }
        {
          key = "ctrl+l";
          command = "workbench.action.navigateRight";
        }

        # Buffer navigation
        {
          key = "shift+l";
          command = "workbench.action.nextEditor";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "shift+h";
          command = "workbench.action.previousEditor";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # Code actions and LSP
        {
          key = "space c a";
          command = "editor.action.quickFix";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "space c r";
          command = "editor.action.rename";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "space c f";
          command = "editor.action.formatDocument";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "space c o";
          command = "editor.action.organizeImports";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "space c a";
          command = "editor.action.quickFix";
          when = "editorTextFocus && vim.mode == 'Visual'";
        }
        {
          key = "space c f";
          command = "editor.action.formatSelection";
          when = "editorTextFocus && vim.mode == 'Visual'";
        }

        # Toggles
        {
          key = "space t i";
          command = "editor.action.toggleInlayHints";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # Go To / Navigation
        {
          key = "g d";
          command = "editor.action.revealDefinition";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "g r";
          command = "editor.action.goToReferences";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # Diagnostics
        {
          key = "] d";
          command = "editor.action.marker.nextInFiles";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "[ d";
          command = "editor.action.marker.prevInFiles";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # Git hunks (requires GitLens or similar extension)
        {
          key = "] h";
          command = "workbench.action.editor.nextChange";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
        {
          key = "[ h";
          command = "workbench.action.editor.previousChange";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # Comments
        {
          key = "g c";
          command = "editor.action.commentLine";
          when = "editorTextFocus && vim.mode == 'Visual'";
        }

        # Fuzzy Finder
        {
          key = "space space";
          command = "workbench.action.quickOpen";
          when = "editorTextFocus && (vim.mode == 'Normal' || vim.mode == 'Visual')";
        }

        # File Explorer
        {
          key = "space e";
          command = "workbench.files.action.showActiveFileInExplorer";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # Projects
        {
          key = "space f p";
          command = "workbench.action.openRecent";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # Search
        {
          key = "space /";
          command = "workbench.action.findInFiles";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }

        # File explorer operations (when focus is on explorer)
        {
          key = "a";
          command = "explorer.newFile";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "shift+a";
          command = "explorer.newFolder";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "r";
          command = "renameFile";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "d";
          command = "deleteFile";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "x";
          command = "filesExplorer.cut";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "c";
          command = "filesExplorer.copy";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "p";
          command = "filesExplorer.paste";
          when = "filesExplorerFocus && !inputFocus";
        }

        # Save
        {
          key = "ctrl+s";
          command = "workbench.action.files.save";
          when = "editorTextFocus && vim.mode == 'Normal'";
        }
      ];
    };
  };
}
