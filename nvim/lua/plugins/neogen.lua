local M = {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  keys = {
    { "<leader>cn", function() require("neogen").generate() end, desc = "Annotate" },
  },
  event = "VeryLazy",
}

function M.config()
  require("neogen").setup {
    enabled = true,
  }
end

return M
