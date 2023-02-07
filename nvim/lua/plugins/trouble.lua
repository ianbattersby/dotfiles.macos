local M = {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
}

function M.config()
  require "trouble".setup {
    position = "bottom",
    height = 10,
    auto_open = false,
    auto_close = false,
    fold_open = "",
    fold_closed = "",
  }
end

return M
