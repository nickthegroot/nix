{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      # Windows
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move To Window Up";
      }

      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move To Window Down";
      }

      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move To Window Left";
      }

      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move To Window Right";
      }

      # Better up/down
      {
        mode = "n";
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          desc = "Down";
          expr = true;
          silent = true;
        };
      }

      {
        mode = "n";
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          desc = "Up";
          expr = true;
          silent = true;
        };
      }

      # Better indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }

      {
        mode = "v";
        key = ">";
        action = ">gv";
      }

      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
        options.desc = "Allow cursor to stay in the same place after appending to current line ";
      }

      # Clear search with ESC
      {
        mode = [
          "n"
          "i"
        ];
        key = "<esc>";
        action = "<cmd>noh<cr><esc>";
        options = {
          silent = true;
          desc = "Escape and clear hlsearch";
        };
      }

      # Paste over stuff without saving the deleted word into the buffer
      {
        mode = "v";
        key = "p";
        action = "\"_dP";
        options.desc = "Deletes to void register and paste over";
      }

      # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action = "\"+y";
        options.desc = "Copy to system clipboard";
      }

      # Delete to void register
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>D";
        action = "\"_d";
        options.desc = "Delete to void register";
      }

      # Goto Previous/Next buffer
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }

      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options.desc = "Previous Buffer";
      }

      # Copy file paths
      {
        mode = "n";
        key = "<leader>Yn";
        action = ''<cmd>let @+ = expand("%:t")<cr>'';
        options.desc = "Yank file [n]ame to clipboard";
      }
      {
        mode = "n";
        key = "<leader>Yf";
        action = ''<cmd>let @+ = expand("%:~:.")<cr>'';
        options.desc = "Yank file relative path to clipboard";
      }
      {
        mode = "n";
        key = "<leader>YF";
        action = ''<cmd>let @+ = expand("%:p")<cr>'';
        options.desc = "Yank file absolute path to clipboard";
      }
    ];

    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>Y";
        mode = [
          "n"
          "v"
        ];
        icon = "";
        group = "+[Y]ank clipboard";
      }
    ];
  };
}
