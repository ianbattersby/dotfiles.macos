local function config()
  require("symbols-outline").setup {
    with = 65,
    preview_bg_highlight = "bg",
  }

  local theme = require("plugins.appearance._theme").name
  local colors = require(theme .. ".colors").setup()

  vim.keymap.set("n", "<leader>cs", "<CMD>SymbolsOutline<CR>", { noremap = true, silent = true, desc = "Symbols" })

  vim.cmd([[
hi FocusedSymbol guibg=]] .. colors.orange0 .. [[

augroup ft_outline
  au!

  au Filetype outline setlocal nolist
augroup end
]])
end

return {
  setup = function(use)
    use {
      "simrat39/symbols-outline.nvim",
      config = config,
    }
  end,
}
