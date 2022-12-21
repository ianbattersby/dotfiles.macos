local M = {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
}

function M.config()
  require("neogen").setup {
    enabled = true,
  }

  vim.keymap.set("n", "<leader>cn", function()
    require("neogen").generate()
  end, { noremap = true, silent = true, desc = "Annotate" })
end

return M
