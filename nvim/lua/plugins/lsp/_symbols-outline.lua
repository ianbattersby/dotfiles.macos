local function config()
  require("symbols-outline").setup {
    with = 65,
    preview_bg_highlight = "bg",
  }

  local theme = require("plugins.appearance._theme").name
  local colors = require(theme .. ".colors").setup()

  require("which-key").register({
    c = {
      s = { ":SymbolsOutline<CR>", "Symbols" },
    },
  }, { prefix = "<leader>" })

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
      after = "which-key.nvim",
      config = config,
    }
  end,
}
