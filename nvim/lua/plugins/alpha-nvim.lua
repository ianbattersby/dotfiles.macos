local M = {
  "goolord/alpha-nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
}

function M.config()
  local startify = require "alpha.themes.startify"

  local top_buttons = {
    startify.button("e", "New file", "<CMD>ene <CR>"),
    startify.button("/", "Last session", [[<cmd>lua require("persistence").load({ last = true })<cr>]]),
  }

  startify.config.layout[4] = vim.tbl_deep_extend("keep", { val = top_buttons }, startify.config.layout[4])

  require("alpha").setup(startify.config)

  vim.keymap.set("n", "<leader>a", "<CMD>Alpha<CR>", { noremap = true, silent = true, desc = "Startup" })
end

return M
