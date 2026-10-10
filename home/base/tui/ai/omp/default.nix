{
  lib,
  oh-my-pi,
  ...
}:
let
  skills = {
    commit = ./skills/commit/SKILL.md;
    pr = ./skills/pr/SKILL.md;
  };
in
{
  imports = [ oh-my-pi.homeManagerModules.default ];

  programs.omp.enable = true;

  home = {
    file = {
      ".omp/agent/AGENTS.md".source = ./AGENTS.md;
      ".omp/agent/RULES.md".source = ./RULES.md;
    }
    // lib.mapAttrs' (
      name: source: lib.nameValuePair ".omp/agent/skills/${name}/SKILL.md" { inherit source; }
    ) skills;

    shellAliases = {
      ompr = "omp --resume";
      gcmomp = "omp --print --no-session '/skill:commit Generate and create a commit from ONLY the staged changes (git diff --cached). Never stage files (no git add).'";
    };
  };
}
