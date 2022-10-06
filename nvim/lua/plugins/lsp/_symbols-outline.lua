local function config()
  require("symbols-outline").setup {
    with = 65,
    preview_bg_highlight = "bg",
  }

  vim.keymap.set("n", "<leader>cs", "<CMD>SymbolsOutline<CR>", { noremap = true, silent = true, desc = "Symbols" })
end

return {
  setup = function(use)
    use {
      "simrat39/symbols-outline.nvim",
      config = config,
    }
  end,
}
