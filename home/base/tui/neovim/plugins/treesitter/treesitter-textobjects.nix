{
  programs.nixvim = {
    plugins.treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "aa" = "@assignment.outer";
            "ia" = "@assignment.inner";
            "ab" = "@block.outer";
            "ib" = "@block.inner";
            "af" = "@function.outer";
            "if" = "@function.inner";
            "aC" = "@class.outer";
            "iC" = "@class.inner";
            "at" = "@comment.outer";
          };
        };
        move = {
          enable = true;
          goto_next_start = {
            "]f" = "@function.outer";
            "]b" = "@block.outer";
          };
          goto_next_end = {
            "]F" = "@function.outer";
            "]B" = "@block.outer";
          };
          goto_previous_start = {
            "[f" = "@function.outer";
            "[b" = "@block.outer";
          };
          goto_previous_end = {
            "[F" = "@function.outer";
            "[B" = "@block.outer";
          };
        };
      };
    };
  };
}
