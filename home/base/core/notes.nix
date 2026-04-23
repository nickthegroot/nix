{ pkgs, ... }:
let
  daily = pkgs.writeShellScriptBin "daily" ''
    #!/bin/bash
    file="$HOME/Notes/daily/$(date "+%Y/%m/%Y-%m-%d.md")"
    mkdir -p "$(dirname "$file")"
    $EDITOR "$file"
  '';
  quicknote = pkgs.writeShellScriptBin "quicknote" ''
    #!/bin/bash
    $EDITOR "$HOME/Notes/$(date +%Y%m%d)-''${1:-$(date +%H%M)}.md"
  '';
  scratchpad = pkgs.writeShellScriptBin "scratchpad" ''
    #!/bin/bash
    $EDITOR $(mktemp -t scratchpad).md
  '';
in
{
  home.packages = [
    daily
    quicknote
    scratchpad
    pkgs.rnote
    pkgs.taskwarrior-tui
  ];

  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    config = {
      sync = {
        # Really not _that_ important to keep secret
        # All traffic either going through wireguard or on LAN
        encryption_secret = "SJaKX1kZHf1Aa2V1RNGIK1cpsX5NHPYQ";

        server = {
          url = "http://taskchampion.worldline.local";
          client_id = "d929ec73-2b9b-46f4-8358-80c1fbfb8018";
        };
      };
    };
  };

  programs.obsidian = {
    enable = true;
    cli.enable = true;
    vaults.Notes.enable = true;

    defaultSettings = {
      app.vimMode = true;

      corePlugins = [
        "audio-recorder"
        "backlink"
        "bases"
        "bookmarks"
        "canvas"
        "command-palette"
        {
          name = "daily-notes";
          enable = true;
          settings = {
            format = "YYYY/MM/YYYY-MM-DD";
            folder = "daily";
          };
        }
        "editor-status"
        "file-explorer"
        "file-recovery"
        "footnotes"
        "global-search"
        "graph"
        "markdown-importer"
        "note-composer"
        "outgoing-link"
        "outline"
        "page-preview"
        "properties"
        "random-note"
        "slash-command"
        "slides"
        "switcher"
        "tag-pane"
        "templates"
        "webviewer"
        "word-count"
        "workspaces"
        "zk-prefixer"
      ];

      appearance = {
        theme = "obsidian"; # Dark mode
        textFontFamily = "Source Han Sans";
        monospaceFontFamily = "Lilex Nerd Font";
      };

      themes = [
        {
          enable = true;
          pkg = pkgs.callPackage ../../../packages/obsidian-catppuccin.nix { };
        }
      ];
    };
  };

  home.shellAliases = {
    t = "task";
    tt = "taskwarrior-tui";

    tw = "task +work";
    twa = "task add +work";

    ta = "task add";
    taw = "task add +work";
  };
}
