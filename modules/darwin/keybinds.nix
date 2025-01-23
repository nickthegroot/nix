{pkgs-stable, ...}: {
  services.skhd = {
    enable = true;
    package = pkgs-stable.skhd;
    skhdConfig = ''
      # focus window
      alt - h: yabai -m window --focus west
      alt - j: yabai -m window --focus south
      alt - k: yabai -m window --focus north
      alt - l: yabai -m window --focus east

      # focus next/prev
      alt - o: yabai -m window --focus next
      alt - i: yabai -m window --focus prev

      # move window to space
      shift + ctrl - 1: yabai -m window --space 1 --focus
      shift + ctrl - 2: yabai -m window --space 2 --focus
      shift + ctrl - 3: yabai -m window --space 3 --focus
      shift + ctrl - 4: yabai -m window --space 4 --focus
      shift + ctrl - 5: yabai -m window --space 5 --focus
      shift + ctrl - 6: yabai -m window --space 6 --focus
      shift + ctrl - 7: yabai -m window --space 7 --focus
      shift + ctrl - 8: yabai -m window --space 8 --focus
      shift + ctrl - 9: yabai -m window --space 9 --focus

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
