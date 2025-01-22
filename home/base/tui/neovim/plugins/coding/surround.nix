{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      modules = {
        surround = {
          mappings = {
            add = "gsa";
            delete = "gsd";
            replace = "gsr";
          };
        };
      };
    };
  };
}
