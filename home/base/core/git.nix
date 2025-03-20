{
  myvars,
  lib,
  pkgs,
  ...
}:
let
  opGpgProgram =
    if pkgs.stdenv.isLinux then
      "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}"
    else
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
in
{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      userName = myvars.userfullname;
      userEmail = myvars.useremail;

      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQiodjunhvMZl0GRixXNkML0iFZsXgax3PjmVLV+0AJ";
        signByDefault = true;
      };

      includes = [
        {
          # use different email for work
          condition = "gitdir:~/Work/";
          contents = {
            user = {
              email = myvars.workemail;
            };
          };
        }
      ];

      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;

        gpg = {
          format = "ssh";
        };

        "gpg \"ssh\"" = {
          program = opGpgProgram;
        };
      };

      delta = {
        enable = true;
        options = {
          diff-so-fancy = true;
          line-numbers = true;
          true-color = "always";
        };
      };
    };

    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-notify
      ];
    };
    gh-dash.enable = true;

    lazygit = {
      enable = true;
      settings = {
        promptToReturnFromSubprocess = false;
      };
    };
  };

  home.shellAliases = {
    # Git
    amend = "git commit --amend --no-edit";
    amendp = "amend && git push --force-with-lease";
    gtop = "cd (git rev-parse --show-toplevel)";
    grec = ''git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | egrep -v '^[a-f0-9]{40}$' | head -n10'';
    gbranch = "git rev-parse --abbrev-ref HEAD";
    gst = "git status";
    gl = "git log";
    gco = "git checkout";
    gcm = "git commit -m";
    gaa = "git add -A";
    gd = "git diff";
    gdc = "git diff --cached";
    gctmp = "git commit \"tmp\" --no-verify --no-gpg-sign";

    # GitHub
    ghc = "gh pr checkout";
    ghp = "gh pr create";
    gha = "gh workflow run --ref (gbranch)";

    # Lazygit
    lg = "lazygit";
  };
}
