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

        "vim.normalModeKeyBindings" = [
          # Better up/down
          {
            "before" = [ "j" ];
            "after" = [ "g" "j" ];
          }
          {
            "before" = [ "k" ];
            "after" = [ "g" "k" ];
          }
          # Join lines keeping cursor in place
          {
            "before" = [ "J" ];
            "commands" = [
              "editor.action.joinLines"
            ];
          }
          # Clear search with ESC
          {
            "before" = [ "<Esc>" ];
            "commands" = [ ":nohl" ];
          }
          # Copy to system clipboard
          {
            "before" = [ "<leader>" "y" ];
            "after" = [ "\"" "+" "y" ];
          }
          # Delete to void register
          {
            "before" = [ "<leader>" "D" ];
            "after" = [ "\"" "_" "d" ];
          }
          # Yank file paths
          {
            "before" = [ "<leader>" "Y" "n" ];
            "commands" = [ "workbench.action.files.copyRelativePath" ];
          }
          {
            "before" = [ "<leader>" "Y" "f" ];
            "commands" = [ "workbench.action.files.copyRelativePath" ];
          }
          {
            "before" = [ "<leader>" "Y" "F" ];
            "commands" = [ "workbench.action.files.copyPath" ];
          }
          # Go to definition
          {
            "before" = [ "g" "d" ];
            "commands" = [ "editor.action.revealDefinition" ];
          }
          # Go to references
          {
            "before" = [ "g" "r" ];
            "commands" = [ "editor.action.goToReferences" ];
          }
          # Hover
          {
            "before" = [ "K" ];
            "commands" = [ "editor.action.showHover" ];
          }
          # Hover Diagnostics
          {
            "before" = [ "T" ];
            "commands" = [ "editor.action.peekProblem" ];
          }
          # Code action
          {
            "before" = [ "<leader>" "c" "a" ];
            "commands" = [ "editor.action.quickFix" ];
          }
          # Rename Symbol
          {
            "before" = [ "<leader>" "c" "r" ];
            "commands" = [ "editor.action.rename" ];
          }
          # Rename File
          {
            "before" = [ "<leader>" "c" "R" ];
            "commands" = [ "fileutils.renameFile" ];
          }
          # Buffer navigation
          {
            "before" = [ "L" ];
            "commands" = [ "workbench.action.nextEditor" ];
          }
          {
            "before" = [ "H" ];
            "commands" = [ "workbench.action.previousEditor" ];
          }
          # Next/Previous reference
          {
            "before" = [ "]" "]" ];
            "commands" = [ "editor.action.wordHighlight.next" ];
          }
          {
            "before" = [ "[" "[" ];
            "commands" = [ "editor.action.wordHighlight.prev" ];
          }
          # Diagnostics
          {
            "before" = [ "]" "d" ];
            "commands" = [ "editor.action.marker.nextInFiles" ];
          }
          {
            "before" = [ "[" "d" ];
            "commands" = [ "editor.action.marker.prevInFiles" ];
          }
          # Git hunks
          {
            "before" = [ "]" "h" ];
            "commands" = [ "workbench.action.editor.nextChange" ];
          }
          {
            "before" = [ "[" "h" ];
            "commands" = [ "workbench.action.editor.previousChange" ];
          }
          # File Explorer
          {
            "before" = [ "<leader>" "e" ];
            "commands" = [ "workbench.files.action.showActiveFileInExplorer" ];
          }
          # Fuzzy Finder
          {
            "before" = [ "<leader>" " " ];
            "commands" = [ "workbench.action.quickOpen" ];
          }
          # Search commands
          {
            "before" = [ "<leader>" "s" "g" ];
            "commands" = [ "workbench.action.findInFiles" ];
          }
          {
            "before" = [ "<leader>" "s" "c" ];
            "commands" = [ "workbench.scm.focus" ];
          }
          # Git commands
          {
            "before" = [ "<leader>" "g" "g" ];
            "commands" = [ "workbench.view.scm" ];
          }
          # Format
          {
            "before" = [ "<leader>" "c" "f" ];
            "commands" = [ "editor.action.formatDocument" ];
          }
          # Toggle Terminal
          {
            "before" = [ "<leader>" "t" "t" ];
            "commands" = [ "workbench.action.terminal.toggleTerminal" ];
          }
        ];

        "vim.visualModeKeyBindings" = [
          # Better indenting
          {
            "before" = [ "<" ];
            "after" = [ "<" "g" "v" ];
          }
          {
            "before" = [ ">" ];
            "after" = [ ">" "g" "v" ];
          }
          # Paste without losing register
          {
            "before" = [ "p" ];
            "after" = [ "\"" "_" "d" "P" ];
          }
          # Copy to system clipboard
          {
            "before" = [ "<leader>" "y" ];
            "after" = [ "\"" "+" "y" ];
          }
          # Delete to void register
          {
            "before" = [ "<leader>" "D" ];
            "after" = [ "\"" "_" "d" ];
          }
          # Format Selection
          {
            "before" = [ "<leader>" "c" "f" ];
            "commands" = [ "editor.action.formatSelection" ];
          }
          # Code action
          {
            "before" = [ "<leader>" "c" "a" ];
            "commands" = [ "editor.action.quickFix" ];
          }
        ];
      };

      keybindings = [
        # Window navigation (Ctrl+h/j/k/l)
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
        {
          key = "j";
          command = "list.focusDown";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "k";
          command = "list.focusUp";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "h";
          command = "list.collapse";
          when = "filesExplorerFocus && !inputFocus";
        }
        {
          key = "l";
          command = "list.expand";
          when = "filesExplorerFocus && !inputFocus";
        }
      ];
    };
  };
}
