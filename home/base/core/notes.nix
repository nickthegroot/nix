{ pkgs, ... }:
let
  newNoteScript = pkgs.writeShellScriptBin "newnote" ''
    #!/bin/bash
    nvim "$HOME/Notes/$(date +%Y%m%d)-$@.md" 
  '';
in
{
  home = {
    packages = [
      # Text Based
      newNoteScript

      # Handwritten Based
      pkgs.rnote
    ];

    shellAliases = {
      "todo" = "nvim $HOME/Notes/todo.md";
    };
  };
}
