local M = {
  "numToStr/Comment.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
}

function M.config()
  require("Comment").setup {
    ignore = "^$",
    mappings = {
      basic = true,
      extra = true,
    },
  }
end

return M
