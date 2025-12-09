{
  services = {
    aerospace = {
      enable = true;
      settings = {
        gaps = {
          outer = {
            left = 10;
            bottom = 10;
            # menu bar is 32px
            top = [
              { monitor.built-in = 4 + 0 + 8; } # tuck menu bar into notch for built-in display
              (4 + 30 + 8) # otherwise use menu bar height + padding
            ];
            right = 10;
          };
          inner = {
            horizontal = 10;
            vertical = 10;
          };
        };

        workspace-to-monitor-force-assignment = (
          builtins.foldl' (acc: elem: acc // elem) { } (
            (
              # 1-5 on primary
              builtins.genList (i: { "${toString (i + 1)}" = "primary"; }) 5
            )
            ++ (
              # 6-9 on secondary
              builtins.genList (i: { "${toString (i + 6)}" = "secondary"; }) 4
            )
          )
        );

        on-focus-changed = [ "move-mouse window-lazy-center" ];

        # Qutebrowser doesn't play nice with window.hide_decoration
        # https://github.com/nikitabobko/AeroSpace/issues/166
        on-window-detected = [
          {
            "if".app-name-regex-substring = "qutebrowser";
            run = "layout tiling";
          }
        ];
      };
    };

    jankyborders = {
      enable = true;

      width = 8.0;
      active_color = "0xFFB4A1DB";
      inactive_color = "0xFF343A40";

      blacklist = [
        "Loom"
      ];
    };
  };
}
