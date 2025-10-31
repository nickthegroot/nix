{ pkgs, ... }:
let
  inherit (pkgs) writeShellScript;

  screenshot = "${pkgs.hyprshot}/bin/hyprshot";
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

    bind = [
      # Apps
      "SUPER,Return,exec,ghostty"
      "ALT,Space,exec,brave"
      "ALTSHIFT,Space,exec,qutebrowser"

      # Hyprland Windows
      "SUPER,Q,killactive"
      "SUPER,F,fullscreen"
      "SUPERSHIFT,F,togglefloating"
      "SUPERSHIFT,P,pin"

      # Selectors
      ",PRINT,exec,${screenshot} -m output -o ~/Pictures/Screenshots -- imv"
      "SUPER,PRINT,exec,${screenshot} -m window -o ~/Pictures/Screenshots -- imv"
      "CTRL,PRINT,exec,${screenshot} -m region -o ~/Pictures/Screenshots -- imv"

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
