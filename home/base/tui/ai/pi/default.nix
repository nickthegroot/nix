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
  extensions = {
    global-prompt-history = ./extensions/global-prompt-history.ts;
  };
in
{
  home = {
    file = {
      ".pi/agent/AGENTS.md".source = ./AGENTS.md;
    }
    // lib.mapAttrs' (
      name: source: lib.nameValuePair ".pi/agent/skills/${name}.md" { inherit source; }
    ) skills
    // lib.mapAttrs' (
      name: source: lib.nameValuePair ".pi/agent/extensions/${name}.ts" { inherit source; }
    ) extensions;

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
