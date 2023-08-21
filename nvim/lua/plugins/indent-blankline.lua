local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = "nvim-treesitter/nvim-treesitter",
}

function M.config()
  vim.opt.list = true
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "tab:⋅→"
  vim.opt.listchars:append "eol:↴"

  require "indent_blankline".setup {
    buftype_exclude = { "terminal", "telescope", "nofile", "packer", "lazy" },
    filetype_exclude = {
      "help",
      "alpha",
      "neo-tree",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "TelescopePrompt",
      "toggleterm",
      "Outline",
      "neotest-summary",
    },
    show_current_context = true,
    show_current_context_start = false,
    use_treesitter = true,
    colored_indent_levels = true,
    char_highlight_list = { "VertSplit" },
  }
end

return M
