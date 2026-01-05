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

        # Buffer navigation (Shift+H/L)
        {
          key = "shift+l";
          command = "workbench.action.nextEditor";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "shift+h";
          command = "workbench.action.previousEditor";
          when = "vim.mode == 'Normal'";
        }

        # File Explorer (<leader>e)
        {
          key = "space e";
          command = "workbench.files.action.showActiveFileInExplorer";
          when = "vim.mode == 'Normal'";
        }

        # Fuzzy Finder (<leader><space>)
        {
          key = "space space";
          command = "workbench.action.quickOpen";
          when = "vim.mode == 'Normal' || vim.mode == 'Visual'";
        }

        # Search commands (<leader>s*)
        {
          key = "space s g";
          command = "workbench.action.findInFiles";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space s c";
          command = "workbench.scm.focus";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space s w";
          command = "editor.action.addSelectionToNextFindMatch";
          when = "vim.mode == 'Normal' || vim.mode == 'Visual'";
        }
        {
          key = "space s s";
          command = "workbench.action.gotoSymbol";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space s shift+s";
          command = "workbench.action.showAllSymbols";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space s d";
          command = "workbench.actions.view.problems";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space s shift+d";
          command = "workbench.panel.markers.view.focus";
          when = "vim.mode == 'Normal'";
        }

        # Git commands (<leader>g*)
        {
          key = "space g g";
          command = "workbench.view.scm";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space g o";
          command = "gitlens.openFileOnRemote";
          when = "vim.mode == 'Normal' || vim.mode == 'Visual'";
        }
        {
          key = "space g y";
          command = "gitlens.copyRemoteFileUrlToClipboard";
          when = "vim.mode == 'Normal' || vim.mode == 'Visual'";
        }

        # LSP commands (<leader>c*)
        {
          key = "space c l";
          command = "workbench.action.showRuntimeExtensions";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space c a";
          command = "editor.action.quickFix";
          when = "vim.mode == 'Normal' || vim.mode == 'Visual'";
        }
        {
          key = "space c r";
          command = "editor.action.rename";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space c shift+r";
          command = "fileutils.renameFile";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space c f";
          command = "editor.action.formatDocument";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space c f";
          command = "editor.action.formatSelection";
          when = "vim.mode == 'Visual'";
        }
        {
          key = "space c o";
          command = "editor.action.organizeImports";
          when = "vim.mode == 'Normal' || vim.mode == 'Visual'";
        }
        {
          key = "space c v";
          command = "python.setInterpreter";
          when = "vim.mode == 'Normal'";
        }

        # Toggle commands (<leader>t*)
        {
          key = "space t i";
          command = "editor.action.toggleInlayHints";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space t f";
          command = "editor.action.formatDocument.none";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space t shift+f";
          command = "editor.action.formatDocument.none";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space t t";
          command = "workbench.action.terminal.toggleTerminal";
          when = "vim.mode == 'Normal'";
        }

        # Go to commands (g*)
        {
          key = "g d";
          command = "editor.action.revealDefinition";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "g r";
          command = "editor.action.goToReferences";
          when = "vim.mode == 'Normal'";
        }

        # Hover (K and T)
        {
          key = "shift+k";
          command = "editor.action.showHover";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "shift+t";
          command = "editor.action.showHover";
          when = "vim.mode == 'Normal'";
        }

        # Next/Previous reference ([[ and ]])
        {
          key = "] ]";
          command = "editor.action.wordHighlight.next";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "[ [";
          command = "editor.action.wordHighlight.prev";
          when = "vim.mode == 'Normal'";
        }

        # Diagnostics (]d and [d)
        {
          key = "] d";
          command = "editor.action.marker.nextInFiles";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "[ d";
          command = "editor.action.marker.prevInFiles";
          when = "vim.mode == 'Normal'";
        }

        # Git hunks (]h and [h)
        {
          key = "] h";
          command = "workbench.action.editor.nextChange";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "[ h";
          command = "workbench.action.editor.previousChange";
          when = "vim.mode == 'Normal'";
        }

        # Yank commands (<leader>Y*)
        {
          key = "space shift+y n";
          command = "copyRelativeFilePath";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space shift+y f";
          command = "copyRelativeFilePath";
          when = "vim.mode == 'Normal'";
        }
        {
          key = "space shift+y shift+f";
          command = "copyFilePath";
          when = "vim.mode == 'Normal'";
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
