local function without_markdownlint(tools)
  return vim.tbl_filter(function(tool)
    return tool ~= "markdownlint-cli2"
  end, tools)
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.markdown = without_markdownlint(opts.linters_by_ft.markdown or {})
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      for _, filetype in ipairs({ "markdown", "markdown.mdx" }) do
        opts.formatters_by_ft[filetype] = without_markdownlint(opts.formatters_by_ft[filetype] or {})
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = without_markdownlint(opts.ensure_installed or {})
    end,
  },
}
