{...}: {
  # terminal file manager
  programs.yazi = {
    enable = true;
    # Changing working directory when exiting Yazi
    enableFishIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}
