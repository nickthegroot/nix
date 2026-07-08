{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
        integrations = {
          blink_cmp = true;
          gitsigns = true;
          mini = true;
          noice = true;
          treesitter = true;
          render_markdown = true;
          snacks = true;
          which_key = true;
          octo = true;
          treesitter_context = true;
        };
      };
    };
  };
}
