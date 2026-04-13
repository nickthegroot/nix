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

      settings = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
        rebase.updateRefs = true;

        gpg = {
          format = "ssh";
        };

        "gpg \"ssh\"" = {
          program = opGpgProgram;
        };

        user = {
          name = myvars.userfullname;
          email = myvars.useremail;
        };
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        true-color = "always";
      };
    };

    gh = {
      enable = true;

      settings.git_protocol = "ssh";
      gitCredentialHelper.enable = false; # just manage via ssh keys

      extensions = with pkgs; [
        gh-enhance
        gh-notify
      ];
    };
    gh-dash.enable = true;

    lazygit = {
      enable = true;
      settings = {
        git.autoFetch = false;
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
    gcor = ''gco (grec | fzf --preview="git log -p --color=always {} | head -n40 | bat --language=diff --color=always" --preview-window=down:70%)'';
    gcob = "git checkout -b";
    gcopr = "gh pr checkout";

    # Stash
    gst = "git stash save";
    gstl = ''git stash list | fzf --preview="git stash show -p (string split -f1 ':' {}) | bat --language=diff --color=always"'';

    # Commit
    gc = "git commit";
    gcm = "git commit -m";
    gctmp = ''gcm "tmp" --no-verify --no-gpg-sign'';
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

    # Codebase diagnostics (https://piechowski.io/post/git-commands-before-reading-code/)
    git-churn = ''git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20'';
    git-bus-factor = "git shortlog -sn --no-merges";
    git-bug-clusters = "git log -i -E --grep=\"fix|bug|broken\" --name-only --format='' | sort | uniq -c | sort -nr | head -20";
    git-velocity = "git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c";
    git-firefighting = "git log --oneline --since=\"1 year ago\" | grep -iE 'revert|hotfix|emergency|rollback'";
  };
}
