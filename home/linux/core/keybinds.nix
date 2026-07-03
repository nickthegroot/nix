{ pkgs, ... }:
let
  inherit (pkgs) lib;

  hypr-app-open = pkgs.hypr-app-open;
  meh = "SUPER + SHIFT + CTRL";

  # Find window classes with:
  # ╰─ hyprctl clients -j | jq -r '.[].class'
  appBinds = {
    "SUPER + Return" = {
      client = "kitty";
      launcher = "kitty";
    };
    "SUPER + SHIFT + Return" = {
      client = "code-url-handler";
      launcher = "code";
    };
    "ALT + Space" = {
      client = "brave-browser";
      launcher = "brave";
    };
    "${meh} + m" = {
      client = "com.github.th_ch.youtube_music";
      launcher = "pear-desktop";
    };
    "${meh} + p" = {
      client = "proton-pass";
      launcher = "proton-pass";
    };
    "${meh} + d" = {
      client = "discord";
      launcher = "discord";
    };
    "${meh} + s" = {
      client = "steam";
      launcher = "steam";
    };
    "${meh} + c" = {
      client = "com.danklinux.dankcalendar";
      launcher = "dcal";
    };
  };
in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      input = {
        kb_layout = "us";
        kb_options = "caps:swapescape";

        repeat_rate = 50; # hz
        repeat_delay = 200; # ms

        # Mouse focus will not switch to the hovered window unless the mouse crosses a window boundary
        follow_mouse = 1;
        mouse_refocus = false;
      };
    };

    bind =
      (lib.mapAttrsToList (key: val: {
        _args = [
          (lib.replaceStrings [ "," ] [ " + " ] key)
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${hypr-app-open}/bin/hypr-app-open ${val.client} ${val.launcher}\")")
        ];
      }) appBinds)
      ++ [
        # Hyprland Windows
        {
          _args = [
            "SUPER + Q"
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            "SUPER + F"
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen()")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + F"
            (lib.generators.mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + P"
            (lib.generators.mkLuaInline "hl.dsp.window.pin()")
          ];
        }

        # Focus
        {
          _args = [
            "SUPER + h"
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"l\" })")
          ];
        }
        {
          _args = [
            "SUPER + j"
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"d\" })")
          ];
        }
        {
          _args = [
            "SUPER + k"
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"u\" })")
          ];
        }
        {
          _args = [
            "SUPER + l"
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"r\" })")
          ];
        }

        # Move
        {
          _args = [
            "SUPER + SHIFT + h"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"l\" })")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + j"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"d\" })")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + k"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"u\" })")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + l"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"r\" })")
          ];
        }

        # Focus Monitor
        {
          _args = [
            "CTRL + SUPER + h"
            (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = \"l\" })")
          ];
        }
        {
          _args = [
            "CTRL + SUPER + j"
            (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = \"d\" })")
          ];
        }
        {
          _args = [
            "CTRL + SUPER + k"
            (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = \"u\" })")
          ];
        }
        {
          _args = [
            "CTRL + SUPER + l"
            (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = \"r\" })")
          ];
        }

        # Move Node to Monitor
        {
          _args = [
            "CTRL + SUPER + SHIFT + h"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ monitor = \"l\" })")
          ];
        }
        {
          _args = [
            "CTRL + SUPER + SHIFT + j"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ monitor = \"d\" })")
          ];
        }
        {
          _args = [
            "CTRL + SUPER + SHIFT + k"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ monitor = \"u\" })")
          ];
        }
        {
          _args = [
            "CTRL + SUPER + SHIFT + l"
            (lib.generators.mkLuaInline "hl.dsp.window.move({ monitor = \"r\" })")
          ];
        }

        # Selectors
        {
          _args = [
            "PRINT"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms screenshot\")")
          ];
        }
        {
          _args = [
            "SUPER + PRINT"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms screenshot full\")")
          ];
        }
        {
          _args = [
            "SUPER + C"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms color pick -a\")")
          ];
        }

        {
          _args = [
            "SUPER + Space"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call spotlight toggle\")")
          ];
        }
        {
          _args = [
            "SUPER + V"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call clipboard toggle\")")
          ];
        }
        {
          _args = [
            "SUPER + N"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call notifications toggle\")")
          ];
        }
        {
          _args = [
            "SUPER + ALT + L"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call lock lock\")")
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + N"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call night toggle\")")
          ];
        }
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
              {
                _args = [
                  "SUPER + ${ws}"
                  (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"${ws}\" })")
                ];
              }
              # Move to ws
              {
                _args = [
                  "SUPER + SHIFT + ${ws}"
                  (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = \"${ws}\" })")
                ];
              }
            ]
          ) 9
        )
      )
      ++ [
        # Locked binds (formerly bindl)
        {
          _args = [
            "XF86AudioMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio mute\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio micmute\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call mpris next\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call mpris previous\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call mpris playPause\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioStop"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call mpris stop\")")
            { locked = true; }
          ];
        }

        # Locked + repeating binds (formerly bindel)
        {
          _args = [
            "XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio increment 3\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio decrement 3\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }

        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call brightness increment 5\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call brightness decrement 5\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }

        # Mouse binds (formerly bindm)
        {
          _args = [
            "SUPER + mouse:272"
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
            { mouse = true; }
          ];
        }
        {
          _args = [
            "SUPER + mouse:273"
            (lib.generators.mkLuaInline "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }
      ];
  };
}
