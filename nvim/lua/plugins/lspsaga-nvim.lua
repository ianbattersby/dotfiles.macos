local M = {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  dependencies = { { "nvim-tree/nvim-web-devicons" } }
}

function M.config()
  require "lspsaga".setup {
    symbol_in_winbar = {
      enable = false,
    },
    outline = {
      win_width = 35,
      auto_close = true,
    },
    lightbulb = {
      virtual_text = false,
    },
    ui = {
      border = "rounded"
    }
  }
end

return M
