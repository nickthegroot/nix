{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        integrations = {
          blink_cmp = true;
          fzf = true;
          gitsigns = true;
          mini = true;
          noice = true;
          treesitter = true;
          render_markdown = true;
          snacks = true;
          which_key = true;
        };
      };
    };

    plugins.lualine.settings.options.theme = "catppuccin";
  };
}
