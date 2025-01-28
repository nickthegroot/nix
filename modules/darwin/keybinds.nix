{pkgs-stable, ...}: {
  services.skhd = {
    enable = true;
    package = pkgs-stable.skhd;
    skhdConfig = ''
      # focus window
      cmd - left: yabai -m window --focus west
      cmd - down: yabai -m window --focus south
      cmd - up: yabai -m window --focus north
      cmd - right: yabai -m window --focus east

      # shift window
      cmd + shift - left: yabai -m window --swap west
      cmd + shift - down: yabai -m window --swap south
      cmd + shift - up: yabai -m window --swap north
      cmd + shift - right: yabai -m window --swap east

      # move window to space
      cmd + shift - 1: yabai -m window --space 1 --focus
      cmd + shift - 2: yabai -m window --space 2 --focus
      cmd + shift - 3: yabai -m window --space 3 --focus
      cmd + shift - 4: yabai -m window --space 4 --focus
      cmd + shift - 5: yabai -m window --space 5 --focus
      cmd + shift - 6: yabai -m window --space 6 --focus
      cmd + shift - 7: yabai -m window --space 7 --focus
      cmd + shift - 8: yabai -m window --space 8 --focus
      cmd + shift - 9: yabai -m window --space 9 --focus

      # common apps
      alt - return: open -a "Ghostty"
      meh - return: open -a "Visual Studio Code"
      meh - space: open -a "Arc"
      meh - m: open -a "YouTube Music"
      meh - o: open -a "Obsidian"
      meh - s: open -a "Slack"
      meh - n: open -a "Notion"
      meh - c: open -a "Notion Calendar"
      meh - l: open -a "Linear"
      meh - x: open -a "Xcode"
      meh - a: yabai -m window --focus (yabai -m query --windows |jq '.[] | select (.app  == "Around") | .id');
    '';
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
