{
  # homebrew need to be installed manually, see https://brew.sh
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'uninstall': uninstalls all formulae, but keeps config files
      # useful for testing nixpkgs versions, and moving back if needed
      cleanup = "uninstall";
    };

    casks = [
      "brave-browser"
      "qutebrowser"

      "ghostty"
      "docker-desktop"

      "notion-calendar"
    ];
  };
}
