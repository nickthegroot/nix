{
  programs.nixvim = {
    plugins.treesitter-textobjects = {
      enable = true;
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
        gotoNextStart = {
          "]m" = "@function.outer";
          "]b" = "@block.outer";
        };
        gotoNextEnd = {
          "]M" = "@function.outer";
          "]B" = "@block.outer";
        };
        gotoPreviousStart = {
          "[m" = "@function.outer";
          "[b" = "@block.outer";
        };
        gotoPreviousEnd = {
          "[M" = "@function.outer";
          "[B" = "@block.outer";
        };
      };
    };
  };
}
