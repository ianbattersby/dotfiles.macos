local M = {
  "simrat39/symbols-outline.nvim",
}

function M.config()
  require("symbols-outline").setup {
    with = 85,
    preview_bg_highlight = "bg",
    auto_close = true,
  }

  vim.keymap.set(
    "n",
    "<leader>co",
    "<CMD>SymbolsOutline<CR>",
    { noremap = true, silent = true, desc = "Symbols (outline)" }
  )
end

return M
