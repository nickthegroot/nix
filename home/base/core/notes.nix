{ pkgs, ... }:
let
  newNoteScript = pkgs.writeShellScriptBin "newnote" ''
    #!/bin/bash
    nvim "$HOME/Notes/$(date +%Y%m%d)-$@.md" 
  '';
in
{
  home.packages = [
    newNoteScript
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

  home.shellAliases = {
    t = "task";
    tt = "taskwarrior-tui";
    tw = "task +work";

    ta = "task add";
    taw = "task add +work";
  };
}
