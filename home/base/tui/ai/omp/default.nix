{
  config,
  lib,
  mylib,
  oh-my-pi,
  pkgs,
  ...
}:
let
  skillFile =
    skillDir:
    lib.nameValuePair ".omp/agent/skills/${baseNameOf skillDir}/SKILL.md" {
      source = skillDir + "/SKILL.md";
    };

  extensionFile =
    extension:
    lib.nameValuePair ".omp/agent/extensions/${baseNameOf extension}" {
      source = extension;
    };

  enabledLspServers = lib.filterAttrs (
    name: server: name != "*" && server.enable
  ) config.programs.nixvim.lsp.servers;
in
{
  imports = [ oh-my-pi.homeManagerModules.default ];

  programs.omp.enable = true;

  home = {
    file =
      {
        ".omp/agent/AGENTS.md".source = ./AGENTS.md;
        ".omp/agent/RULES.md".source = ./RULES.md;
      }
      // builtins.listToAttrs (map skillFile (mylib.scanPaths ./skills))
      // builtins.listToAttrs (map extensionFile (mylib.scanFiles ./extensions));

    shellAliases = {
      ompr = "omp --resume";
      gcmai = "omp --print --no-session '/skill:commit Generate and create a commit from ONLY the staged changes (git diff --cached). Never stage files (no git add).'";
    };

    # omp registers a language server only when its binary resolves on $PATH, so mirror nixvim's packages
    # Add typescript-language-server for dual projects, where otherwise nothing is activated
    packages =
      lib.unique (
        lib.filter (package: package != null) (
          lib.mapAttrsToList (_: server: server.package) enabledLspServers
        )
      )
      ++ [ pkgs.typescript-language-server ];
  };
}
