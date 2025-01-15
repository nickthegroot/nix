return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", "<Cmd>TmuxNavigateLeft<CR>" },
    { "<C-j>", "<Cmd>TmuxNavigateDown<CR>" },
    { "<C-k>", "<Cmd>TmuxNavigateUp<CR>" },
    { "<C-l>", "<Cmd>TmuxNavigateRight<CR>" },
  },
}
