{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # focus window
      alt - h: yabai -m window --focus west
      alt - j: yabai -m window --focus south
      alt - k: yabai -m window --focus north
      alt - l: yabai -m window --focus east

      # shift window
      alt + shift - h: yabai -m window --swap west
      alt + shift - j: yabai -m window --swap south
      alt + shift - k: yabai -m window --swap north
      alt + shift - l: yabai -m window --swap east

      # move window to space
      alt + shift - 1: yabai -m window --space 1 --focus
      alt + shift - 2: yabai -m window --space 2 --focus
      alt + shift - 3: yabai -m window --space 3 --focus
      alt + shift - 4: yabai -m window --space 4 --focus
      alt + shift - 5: yabai -m window --space 5 --focus
      alt + shift - 6: yabai -m window --space 6 --focus
      alt + shift - 7: yabai -m window --space 7 --focus
      alt + shift - 8: yabai -m window --space 8 --focus
      alt + shift - 9: yabai -m window --space 9 --focus

      # common apps
      alt - return: open -a "Ghostty"
      alt + shift - return: open -a "Zed"
      alt - space: open -a "Arc"

      # less common, but still important
      meh - m: open -a "YouTube Music"
      meh - o: open -a "Obsidian"
      meh - s: open -a "Slack"
      meh - n: open -a "Notion"
      meh - c: open -a "Notion Calendar"
      meh - l: open -a "Linear"
      meh - x: open -a "Xcode"
    '';
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
