{ pkgs-unstable, lib, ... }:
let
  skills = {
    caveman = ./skills/caveman.md;
    commit = ./skills/commit.md;
  };
in
{
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;

    inherit skills;

    settings = {
      autoupdate = false;
    };

    context = ./AGENTS.md;
  };

  # TODO: Move to `programs.pi-coding-agent` for 26.11 (or backported to 26.05)
  home.file = {
    ".pi/agent/AGENTS.md".source = ./AGENTS.md;
  }
  // lib.mapAttrs' (
    name: source: lib.nameValuePair ".pi/agent/skills/${name}.md" { inherit source; }
  ) skills;

  home.packages = with pkgs-unstable; [
    pi-coding-agent
  ];
}
