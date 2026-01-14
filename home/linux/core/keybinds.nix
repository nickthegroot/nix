{ pkgs, ... }:
let
  inherit (pkgs) lib callPackage;

  hypr-app-open = callPackage ../../../packages/hypr-app-open.nix { };
  meh = "SUPER + SHIFT + CTRL";

  # Find window classes with:
  # ╰─ hyprctl clients -j | jq -r '.[].class'
  appBinds = {
    "SUPER,Return" = {
      client = "com.mitchellh.ghostty";
      launcher = "ghostty";
    };
    "SUPERSHIFT,Return" = {
      client = "code-url-handler";
      launcher = "code";
    };
    "ALT,Space" = {
      client = "brave-browser";
      launcher = "brave";
    };
    "${meh},m" = {
      client = "com.github.th_ch.youtube_music";
      launcher = "pear-desktop";
    };
    "${meh},p" = {
      client = "1password";
      launcher = "1password";
    };
    "${meh},d" = {
      client = "discord";
      launcher = "discord";
    };
    "${meh},s" = {
      client = "steam";
      launcher = "steam";
    };
  };
in
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      kb_options = "caps:swapescape";

      repeat_rate = 50; # hz
      repeat_delay = 200; # ms

      # Mouse focus will not switch to the hovered window unless the mouse crosses a window boundary
      follow_mouse = 1;
      mouse_refocus = false;
    };

    # Note: bind flags `bind[flags]
    # https://wiki.hypr.land/Configuring/Binds/#bind-flags
    # l = locked (works during lock screen)
    # e = repeat enabled (hold key to repeat)
    # m = mouse
    bind =
      (lib.mapAttrsToList (
        key: val: "${key},exec,${hypr-app-open}/bin/hypr-app-open ${val.client} ${val.launcher}"
      ) appBinds)
      ++ [
        # Hyprland Windows
        "SUPER,Q,killactive"
        "SUPER,F,fullscreen"
        "SUPERSHIFT,F,togglefloating"
        "SUPERSHIFT,P,pin"

        # Focus
        "SUPER,h,movefocus,l"
        "SUPER,j,movefocus,d"
        "SUPER,k,movefocus,u"
        "SUPER,l,movefocus,r"

        # Move
        "SUPERSHIFT,h,movewindow,l"
        "SUPERSHIFT,j,movewindow,d"
        "SUPERSHIFT,k,movewindow,u"
        "SUPERSHIFT,l,movewindow,r"

        # Focus Monitor
        "CTRLSUPER,h,focusmonitor,l"
        "CTRLSUPER,j,focusmonitor,d"
        "CTRLSUPER,k,focusmonitor,u"
        "CTRLSUPER,l,focusmonitor,r"

        # Move Node to Monitor
        "CTRLSUPERSHIFT,h,movewindow,mon:l"
        "CTRLSUPERSHIFT,j,movewindow,mon:d"
        "CTRLSUPERSHIFT,k,movewindow,mon:u"
        "CTRLSUPERSHIFT,l,movewindow,mon:r"

        # Selectors
        ", PRINT, exec, dms screenshot" # Region select
        "SUPER, PRINT, exec, dms screenshot full" # Focused screen
        "SUPER, C, exec, dms color pick -a" # Color picker (hex), to clipboard

        "SUPER, Space, exec, dms ipc call spotlight toggle"
        "SUPER, V, exec, dms ipc call clipboard toggle"
        "SUPER, N, exec, dms ipc call notifications toggle"
        "SUPERALT, L, exec, dms ipc call lock lock"
        # "SUPERSHIFT, /, exec, dms keybinds show hyprland"
        "SUPERSHIFT, N, exec, dms ipc call night toggle"
      ]
      ++ (
        # workspaces 1-9
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = toString (i + 1);
            in
            [
              # Switch to ws
              "SUPER,${ws},workspace,${ws}"
              # Move to ws
              "SUPERSHIFT,${ws},movetoworkspace,${ws}"
            ]
          ) 9
        )
      );

    bindl = [
      ", XF86AudioMute, exec, dms ipc call audio mute"
      ", XF86AudioMicMute, exec, dms ipc call audio micmute"
      ", XF86AudioNext, exec, dms ipc call mpris next"
      ", XF86AudioPrev, exec, dms ipc call mpris previous"
      ", XF86AudioPlay, exec, dms ipc call mpris playPause"
      ", XF86AudioStop, exec, dms ipc call mpris stop"
    ];
    bindel = [
      # Audio controls (function keys)
      ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 3"
      ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 3"

      # Brightness controls (function keys)
      ", XF86MonBrightnessUp, exec, dms ipc call brightness increment 5"
      ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5"
    ];
    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];
  };
}
