{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gnugrep # replacee macos's grep
    gnutar # replacee macos's tar
  ];

  # homebrew need to be installed manually, see https://brew.sh
  # https://github.com/LnL7/nix-darwin/blob/master/modules/homebrew.nix
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    taps = [
      "th-ch/youtube-music"
    ];

    # `brew install --cask`
    casks = [
      "arc"

      "ghostty"
      "docker"

      "notion-calendar"
      "notion"

      "protonvpn"

      # Misc
      "iina" # better mpv for macos
      "legcord" # better discord client
      "raycast"
      "1password"
      "th-ch/youtube-music/youtube-music"
    ];
  };
}
