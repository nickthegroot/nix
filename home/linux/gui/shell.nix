{ dank-material-shell, wallpapers, ... }:
{
  imports = [ dank-material-shell.homeModules.dankMaterialShell.default ];

  programs.dankMaterialShell.enable = true;

  # https://github.com/AvengeMedia/DankMaterialShell?tab=readme-ov-file#hyprland-integration
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "bash -c \"wl-paste --watch cliphist store &\""
      "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1"
      "dms run"
    ];

    bind = [
      "SUPER, Space, exec, dms ipc call spotlight toggle"
      "SUPER, V, exec, dms ipc call clipboard toggle"
      "SUPER, M, exec, dms ipc call processlist toggle"
      "SUPER, N, exec, dms ipc call notifications toggle"
      "SUPER, comma, exec, dms ipc call settings toggle"
      "SUPER, P, exec, dms ipc call notepad toggle"
      "SUPERALT, L, exec, dms ipc call lock lock"
      "SUPER, X, exec, dms ipc call powermenu toggle"
      "SUPER, Y, exec, dms ipc call dankdash wallpaper"
      "SUPER, C, exec, dms ipc call control-center toggle"
      "SUPER, TAB, exec, dms ipc call hypr toggleOverview"
      "SUPERSHIFT, N, exec, dms ipc call night toggle"
    ];

    bindl = [
      # Audio controls (function keys)
      ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 3"
      ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 3"
      ", XF86AudioMute, exec, dms ipc call audio mute"
      ", XF86AudioMicMute, exec, dms ipc call audio micmute"
      ", XF86AudioNext, exec, dms ipc call mpris next"
      ", XF86AudioPrev, exec, dms ipc call mpris previous"
      ", XF86AudioPlay, exec, dms ipc call mpris playPause"
      ", XF86AudioStop, exec, dms ipc call mpris stop"

      # Brightness controls (function keys)
      ", XF86MonBrightnessUp, exec, dms ipc call brightness increment 5"
      ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5"
    ];
  };

  home.file."Pictures/Wallpapers" = {
    recursive = true;
    source = wallpapers;
  };
}
