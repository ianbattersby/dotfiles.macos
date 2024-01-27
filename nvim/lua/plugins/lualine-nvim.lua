return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "folke/noice.nvim",
  },
  event = "VeryLazy",
  opts = function()
    local catppuccin_opts = require "util".opts "catppuccin"
    return {
      float = vim.tbl_contains(catppuccin_opts.background_clear or {}, "neo-tree"),
      separator = "bubble", -- bubble | triangle
      ---@type any
      colorful = true,
    }
  end,
  config = function(_, opts)
    local lualine_config = require "config.lualine"
    lualine_config.setup(opts)
    lualine_config.load()
  end,
}
