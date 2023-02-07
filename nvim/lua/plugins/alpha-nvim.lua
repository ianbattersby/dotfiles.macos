local M = {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/persistence.nvim" },
  lazy = false,
  keys = {
    { "<leader>a", "<CMD>Alpha<CR>", desc = "Startup" }
  },
}

function M.config()
  local startify = require "alpha.themes.startify"

  local top_buttons = {
    startify.button("e", "New file", "<CMD>ene <CR>"),
    startify.button("/", "Last session", [[<cmd>lua require("persistence").load({ last = true })<cr>]]),
  }

  startify.config.layout[4] = vim.tbl_deep_extend("keep", { val = top_buttons }, startify.config.layout[4])

  require "alpha".setup(startify.config)
end

return M
