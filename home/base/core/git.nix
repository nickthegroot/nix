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

      settings.git_protocol = "ssh";
      gitCredentialHelper.enable = false; # just manage via ssh keys

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
    gtop = "cd (git rev-parse --show-toplevel)";
    grec = ''git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | egrep -v '^[a-f0-9]{40}$' | head -n10'';
    gbranch = "git rev-parse --abbrev-ref HEAD";
    gs = "git status";
    gl = "git log";
    gaa = "git add -A";
    gd = "git diff";
    gdc = "git diff --cached";

    # Checkout
    gco = "git checkout";
    gcor = "gco (grec | fzf)";
    gcob = "git checkout -b";
    gcopr = "gh pr checkout";

    # Stash
    gst = "git stash save";
    gstl = ''git stash list | fzf --preview="git stash show -p (string split -f1 ':' {}) | bat --language=diff --color=always"'';

    # Commit
    gc = "git commit";
    gcm = "git commit -m";
    gctmp = "git commit \"tmp\" --no-verify --no-gpg-sign";
    amend = "git commit --amend --no-edit";
    amendp = "amend && git push --force-with-lease";

    # Push
    gp = "git push";
    gpf = "git push --force-with-lease";

    # PR
    pr = "gh pr create";

    # GitHub Actions
    gha = "gh workflow run --ref (gbranch)";

    # Lazygit
    lg = "lazygit";
  };
}
