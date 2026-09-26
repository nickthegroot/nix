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
    arg="''${1:-}"
    if [[ "$arg" == */ ]]; then
      folder="''${arg%/}"
      name=""
    else
      folder="$(dirname "$arg")"
      name="$(basename "$arg")"
      [ "$folder" = "." ] && folder=""
    fi
    [ -z "$name" ] && name="$(date +%H%M)"
    mkdir -p "$HOME/Notes/$folder"
    $EDITOR "$HOME/Notes/''${folder:+$folder/}$(date +%Y%m%d)-$name.md"
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
  ];

  programs.obsidian = {
    enable = true;
    cli.enable = true;
    vaults.Notes.enable = true;
    vaults.Catppuccin.enable = true;

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
    };
  };
}
