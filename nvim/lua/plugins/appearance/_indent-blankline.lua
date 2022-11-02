local function config()
  vim.opt.list = true
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "tab:⋅→"
  vim.opt.listchars:append "eol:↴"

  require("indent_blankline").setup {
    buftype_exclude = { "terminal", "telescope", "nofile", "packer" },
    filetype_exclude = {
      "help",
      "alpha",
      "packer",
      "neo-tree",
      "Trouble",
      "TelescopePrompt",
      "Outline",
      "mind",
      "neotest-summary",
    },
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    use_treesitter = true,
    colored_indent_levels = false,
  }
end

return {
  setup = function(use)
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = config,
    }
  end,
}
