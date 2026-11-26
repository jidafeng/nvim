return {
  "christoomey/vim-tmux-navigator",
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_no_wrap = 1
  end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Focus split or pane to the left" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Focus split or pane below" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Focus split or pane above" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Focus split or pane to the right" },
  },
}
