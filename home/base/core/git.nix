{myvars, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = myvars.userfullname;
    userEmail = myvars.useremail;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    # A syntax-highlighting pager in Rust(2019 ~ Now)
    delta = {
      enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
        # features => named groups of settings, used to keep related settings organized
        # features = "";
      };
    };
  };

  programs.gh.enable = true;
  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
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

    # GitHub
    ghc = "gh pr checkout";
    ghp = "gh pr create";
    gha = "gh workflow run --ref (git rev-parse --abbr-ref HEAD)";
  };
}
