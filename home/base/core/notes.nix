{ pkgs, ... }:
let
  newNoteScript = pkgs.writeShellScriptBin "newnote" ''
    #!/bin/bash
    nvim "$HOME/Notes/$(date +%Y%m%d)-$@.md" 
  '';
in
{
  home = {
    packages = [ newNoteScript ];
    shellAliases = {
      "todo" = "nvim $HOME/Notes/todo.md";
    };
  };
}
