{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      on_last_window_closed = "quit_app";

      ui_font_family = "JetBrainsMono Nerd Font";
      buffer_font_family = "JetBrainsMono Nerd Font";

      relative_line_numbers = true;
      vim_mode = true;
      vim = {
        use_system_clipboard = "on_yank";
      };
    };

    userKeymaps = [
      {
        bindings = {
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-l = "workspace::ActivatePaneRight";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-j = "workspace::ActivatePaneDown";
        };
      }

      {
        context = "VimControl && !menu";
        bindings = {
          "space space" = "file_finder::Toggle";
        };
      }
    ];
  };
}
