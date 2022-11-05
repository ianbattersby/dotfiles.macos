local function config()
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

return {
  setup = function(use)
    use {
      "simrat39/symbols-outline.nvim",
      config = config,
    }
  end,
}
