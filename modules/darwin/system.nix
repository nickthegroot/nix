{pkgs, ...}: {
  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local = {
    enable = true;
    reattach = true; # Required for tmux usage
    touchIdAuth = true;
  };

  time.timeZone = "America/Los_Angeles";

  system = {
    defaults = {
      # customize dock
      dock = {
        autohide = true; # automatically hide and show the dock
        show-recents = false; # do not show recent apps in dock
        # do not automatically rearrange spaces based on most recent use.
        mru-spaces = false;
        expose-group-apps = true; # Group windows by application

        # hot corners
        wvous-bl-corner = 1; # disabled
        wvous-br-corner = 1; # disabled
        wvous-tl-corner = 1; # disabled
        wvous-tr-corner = 1; # disabled
      };

      # customize finder
      finder = {
        _FXShowPosixPathInTitle = false; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        AppleShowAllFiles = true; # show all files
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        FXDefaultSearchScope = "SCcf"; # search current folder by default
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      # customize trackpad
      trackpad = {
        Clicking = false; # require full click (vs. tap)
        TrackpadRightClick = true; # enable two finger right click
        TrackpadThreeFingerDrag = false; # use three finger for switching desktop spaces
      };

      # customize macOS
      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = false; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key

        # Appearance
        AppleInterfaceStyle = "Dark"; # dark mode

        AppleEnableMouseSwipeNavigateWithScrolls = false; # Disable swipe to navigate (e.g. in browser)
        AppleEnableSwipeNavigateWithScrolls = false; # Disable swipe to navigate (e.g. in browser)
        ApplePressAndHoldEnabled = false; # enable press and hold

        AppleSpacesSwitchOnActivate = true; # Auto switch to active application's Space

        _HIHideMenuBar = true; # Autohide menu bar

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 2; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
    };
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      noto-fonts-emoji
      source-sans
      source-serif
      source-han-sans # CJK Support
      source-han-serif # CJK Support

      nerd-fonts.jetbrains-mono
      julia-mono
    ];
  };
}
