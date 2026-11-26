-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("dashboard_after_last_buffer", { clear = true }),
  desc = "Show the startup dashboard after closing the last buffer",
  callback = function(event)
    -- BufDelete fires before Neovim finishes choosing the replacement buffer.
    vim.schedule(function()
      if vim.v.exiting ~= vim.NIL or vim.fn.buflisted(event.buf) == 1 then
        return
      end

      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)
      local options = vim.bo[buf]
      if vim.api.nvim_win_get_config(win).relative ~= ""
        or options.buftype ~= ""
        or options.filetype ~= ""
        or options.modified
        or vim.api.nvim_buf_get_name(buf) ~= ""
        or vim.api.nvim_buf_line_count(buf) ~= 1
        or vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] ~= ""
      then
        return
      end

      for _, listed in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if listed.bufnr ~= buf then
          return
        end
      end

      -- A replacement buffer can be shared by multiple splits.
      local dashboard_buf = #vim.fn.win_findbuf(buf) == 1 and buf or nil
      Snacks.dashboard.open({ buf = dashboard_buf, win = win })
    end)
  end,
})
