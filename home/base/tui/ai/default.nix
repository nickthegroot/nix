{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  skills = {
    commit = ./skills/commit.md;
    plan = ./skills/plan.md;
    pr = ./skills/pr.md;
  };
in
{
  home = {
    file = {
      ".pi/agent/AGENTS.md".source = ./AGENTS.md;
    }
    // lib.mapAttrs' (
      name: source: lib.nameValuePair ".pi/agent/skills/${name}.md" { inherit source; }
    ) skills;

    packages = [
      pkgs-unstable.pi-coding-agent
      pkgs.pi-acp
    ];

    shellAliases = {
      pir = "pi --resume";
      gcmai = "pi --print --no-session '/skill:commit Generate and create a commit from ONLY the staged changes (git diff --cached). Never stage files (no git add).'";
    };
  };
}
