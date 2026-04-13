{
  programs.nixvim = {
    plugins.octo = {
      enable = true;
      settings = {
        picker = "snacks";
        enable_builtin = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gps";
        action = "<CMD>Octo review start<CR>";
        options.desc = "Start Review";
      }
      {
        mode = "n";
        key = "<leader>gpr";
        action = "<CMD>Octo review resume<CR>";
        options.desc = "Resume Review";
      }
      {
        mode = "n";
        key = "<leader>gpS";
        action = "<CMD>Octo review submit<CR>";
        options.desc = "Submit Review";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>gpc";
        action = "<CMD>Octo comment add<CR>";
        options.desc = "Comment";
      }
    ];

    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>gp";
        mode = "n";
        group = "+pull requests";
      }
    ];
  };
}
