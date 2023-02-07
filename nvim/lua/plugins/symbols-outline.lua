local M = {
  "simrat39/symbols-outline.nvim",
  keys = {
    { "<leader>co", "<CMD>SymbolsOutline</CR>", desc = "Symbols (Outline)" },
  },
  event = "VeryLazy",
}

function M.config()
  require "symbols-outline" .setup {
    with = 85,
    preview_bg_highlight = "bg",
    auto_close = true,
  }
end

return M
