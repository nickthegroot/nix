{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      vim_mode = true;
      relative_line_numbers = true;
      vim = {
        use_system_clipboard = "on_yank";
      };
    };
  };
}
