{
  programs.nixvim = {
    config = {
      opts = {
        # Enable relative line numbers
        number = true;
        relativenumber = true;

        # Tab spacing 2 spaces
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;

        smartindent = true;
        wrap = true;

        # Smart indent on word wrap
        breakindent = true;

        # Undo stuff from days ago
        swapfile = false;
        backup = false;
        undofile = true;

        # Incremental search
        hlsearch = true;
        incsearch = true;

        # Better splitting
        splitbelow = true;
        splitright = true;

        # Enable ignorecase + smartcase for better searching
        ignorecase = true;
        smartcase = true; # Don't ignore case with capitals
        grepprg = "rg --vimgrep";
        grepformat = "%f:%l:%c:%m";

        # Better colors
        termguicolors = true;

        # Decrease updatetime
        updatetime = 50; # faster completion (4000ms default)

        # Enable the sign column to prevent the screen from jumping
        signcolumn = "yes";

        # Reduce which-key timeout to 250s
        timeoutlen = 250;

        scrolloff = 8; # Will never have less than 8 characters as you scroll down
        mouse = "a"; # Mouse
        confirm = true; # confirm before exiting modified buffer
        cursorline = true; # highlight current line

        # Set encoding type
        encoding = "utf-8";
        fileencoding = "utf-8";
      };
    };
  };
}
