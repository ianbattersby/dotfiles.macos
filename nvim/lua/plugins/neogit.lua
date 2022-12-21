local M = {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  require("neogit").setup {}
end

return M
