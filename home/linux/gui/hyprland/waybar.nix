_: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = builtins.readFile ./conf/waybar/style.css;
    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        modules-left = ["custom/launcher" "hyprland/workspaces"];
        modules-center = ["custom/playerctl"];
        modules-right = [
          "pulseaudio"
          "battery"
          "memory"
          "cpu"
          "network"
          "clock"
          "tray"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };

        clock = {
          interval = 60;
          align = 0;
          rotate = 0;
          tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          format = " {:%I:%M %p}";
          format-alt = " {:%a %b %d, %G}";
        };
        cpu = {
          format = " {usage}%";
          interval = 1;
        };
        "custom/launcher" = {
          format = " ";
          on-click = "$HOME/.config/hypr/scripts/menu";
          on-click-middle = "exec default_wall";
          on-click-right = "exec wallpaper_random";
          tooltip = false;
        };
        memory = {
          format = " {percentage}%";
          interval = 1;
          states = {
            warning = 85;
          };
        };
        "custom/playerctl" = {
          format = "{icon}  <span>{}</span>";
          return-type = "json";
          max-length = 55;
          exec = "playerctl -a metadata --format '{\"text\": \"  {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click-middle = "playerctl previous";
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          format-icons = {
            Paused = "<span foreground='#6dd9d9'></span>";
            Playing = "<span foreground='#82db97'></span>";
          };
        };
        network = {
          interval = 5;
          format-wifi = " {essid}";
          format-ethernet = " {ipaddr}/{cidr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "睊 Disconnected";
          format-disabled = "睊 Disabled";
          format-alt = " {bandwidthUpBytes} |  {bandwidthDownBytes}";
          tooltip-format = " {ifname} via {gwaddr}";
          on-click-middle = "nm-connection-editor";
          on-click-right = "ghostty nmtui";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Mute";
          format-bluetooth = " {volume}% {format_source}";
          format-bluetooth-muted = " Mute";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          scroll-step = 5.0;
          on-click = "amixer set Master toggle";
          on-click-right = "pavucontrol";
          smooth-scrolling-threshold = 1;
        };
        tray = {
          icon-size = 15;
          spacing = 5;
        };
      };
    };
  };
}
