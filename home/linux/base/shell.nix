{myvars, ...}: {
  home.homeDirectory = "/home/${myvars.username}";

  # environment variables that always set at login
  home.sessionVariables = {
    # set default applications
    BROWSER = "zen";

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";
  };
}
