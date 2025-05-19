{ pkgs, ... }:
let
  inherit (pkgs) writeShellScript;

  toggleRofi = writeShellScript "toggle-rofi" ''
    if [[ ! $(pidof rofi) ]]; then
    	rofi -show-icons -show "$@"
    else
    	pkill rofi
    fi
  '';
  pickColor = writeShellScript "pick-color" ''
    ${pkgs.hyprpicker}/bin/hyprpicker | ${pkgs.wl-clipboard}/bin/wl-copy
  '';
  screenshot = "${pkgs.hyprshot}/bin/hyprshot";
  setVolume = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@";
  mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
in
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      kb_options = "caps:swapescape";

      # Mouse focus will not switch to the hovered window unless the mouse crosses a window boundary
      follow_mouse = 1;
      mouse_refocus = false;
    };

    bind =
      [
        # Apps
        "SUPER,Return,exec,ghostty"
        "SUPER,Space,exec,${toggleRofi} drun"
        "SUPERSHIFT,Space,exec,${toggleRofi} clipboard -modi clipboard:${pkgs.cliphist}/bin/cliphist-rofi-img"
        "ALT,Space,exec,qutebrowser"

        # Hyprland Windows
        "SUPER,Q,killactive"
        "SUPER,F,fullscreen"
        "SUPERSHIFT,F,togglefloating"
        "SUPERSHIFT,P,pin"

        # Function keys
        ",XF86AudioRaiseVolume,exec,${setVolume} 5%+"
        ",XF86AudioLowerVolume,exec,${setVolume} 5%-"
        ",XF86AudioMute,exec,${mute}"
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPrev,exec,playerctl previous"
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioStop,exec,playerctl stop"

        # Selectors
        "SUPER,P,exec,${pickColor}"
        ",PRINT,exec,${screenshot} -m output -o ~/Pictures/Screenshots -- imv"
        "SUPER,PRINT,exec,${screenshot} -m window -o ~/Pictures/Screenshots -- imv"
        "CTRL,PRINT,exec,${screenshot} -m region -o ~/Pictures/Screenshots -- imv"

        # Focus
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"

        # Move
        "SUPERSHIFT,left,movewindow,l"
        "SUPERSHIFT,right,movewindow,r"
        "SUPERSHIFT,up,movewindow,u"
        "SUPERSHIFT,down,movewindow,d"

        # Resize
        "SUPERCTRL,left,resizeactive,-20 0"
        "SUPERCTRL,right,resizeactive,20 0"
        "SUPERCTRL,up,resizeactive,0 -20"
        "SUPERCTRL,down,resizeactive,0 20"

        # Monitor
        "SUPER CTRL,l,focusmonitor,r"
        "SUPER CTRL,h,focusmonitor,l"

        # Send to Monitor
        "SUPER SHIFT CTRL,h,movecurrentworkspacetomonitor,l"
        "SUPER SHIFT CTRL,l,movecurrentworkspacetomonitor,r"
        "SUPER CTRL,l,focusmonitor,r"
        "SUPER CTRL,h,focusmonitor,l"
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

    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];
  };
}
