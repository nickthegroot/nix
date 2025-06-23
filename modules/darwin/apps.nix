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
      # 'uninstall': uninstalls all formulae, but keeps config files
      # useful for testing nixpkgs versions, and moving back if needed
      cleanup = "uninstall";
    };

    taps = [
      "th-ch/youtube-music"
    ];

    casks = [
      "qutebrowser"

      "ghostty"
      "docker"

      "notion-calendar"
      "notion"

      # Misc
      "iina" # better mpv for macos
      "legcord" # better discord client
      "jellyfin-media-player" # prebuilt qutebrowser doesn't have proprietary codecs
      "protonvpn"
      "raycast"
      "1password"
      "th-ch/youtube-music/youtube-music"
    ];
  };
}
