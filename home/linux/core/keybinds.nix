{ pkgs, ... }:
let
  inherit (pkgs) lib;

  hypr-app-open = pkgs.writeShellScriptBin "hypr-app-open" ''
    client="$1"
    launcher="$2"

    clients_json=$(hyprctl clients -j)
    current_id=$(hyprctl activewindow -j | ${pkgs.jq}/bin/jq -r '.address')
    matching_windows=$(echo "$clients_json" | ${pkgs.jq}/bin/jq --arg c "$client" '[.[] | select(.class == $c)]')
    count=$(echo "$matching_windows" | ${pkgs.jq}/bin/jq -r 'length')

    if [ "$count" -eq 0 ]; then
      exec "$launcher" &
      exit
    fi

    current_win=$(echo "$clients_json" | ${pkgs.jq}/bin/jq -r --arg id "$current_id" '.[] | select(.address == $id)')
    current_class=$(echo "$current_win" | ${pkgs.jq}/bin/jq -r '.class // empty')

    if [ "$current_class" = "$client" ]; then
      # Exclude current window, pick most recent other
      target=$(echo "$matching_windows" | ${pkgs.jq}/bin/jq -r --arg id "$current_id" '[.[] | select(.address != $id)] | sort_by(-.focusHistoryID) | .[0]')
    else
      # Pick most recent
      target=$(echo "$matching_windows" | ${pkgs.jq}/bin/jq -r 'sort_by(-.focusHistoryID) | .[0]')
    fi

    target_addr=$(echo "$target" | ${pkgs.jq}/bin/jq -r '.address // empty')

    if [ -n "$target_addr" ]; then
      hyprctl dispatch focuswindow address:"$target_addr"
    else
      exec "$launcher" &
    fi
  '';

  screenshot = "${pkgs.hyprshot}/bin/hyprshot";

  meh = "SUPER + SHIFT + CTRL";

  # Find window classes with:
  # ╰─ hyprctl clients -j | jq -r '.[].class'
  appBinds = {
    "SUPER,Return" = {
      client = "com.mitchellh.ghostty";
      launcher = "ghostty";
    };
    "SUPERSHIFT,Return" = {
      client = "dev.zed.Zed";
      launcher = "zeditor";
    };
    "ALT,Space" = {
      client = "brave-browser";
      launcher = "brave";
    };
    "ALTSHIFT,Space" = {
      client = "org.qutebrowser.qutebrowser";
      launcher = "qutebrowser";
    };
    "${meh},m" = {
      client = "com.github.th_ch.youtube_music";
      launcher = "youtube-music";
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

      # Mouse focus will not switch to the hovered window unless the mouse crosses a window boundary
      follow_mouse = 1;
      mouse_refocus = false;
    };

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

        # Selectors
        ",PRINT,exec,${screenshot} -m region -o ~/Pictures/Screenshots -- imv"
        "SUPER,PRINT,exec,${screenshot} -m window -o ~/Pictures/Screenshots -- imv"
        "CTRL,PRINT,exec,${screenshot} -m output  -o ~/Pictures/Screenshots -- imv"

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
