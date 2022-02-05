local function config()
  local theme = require("plugins.appearance._theme").name
  local colors = require(theme .. ".colors").setup()

  require("which-key").register({
    c = {
      s = { ":SymbolsOutline<CR>", "Symbols" },
    },
  }, { prefix = "<leader>" })

  vim.cmd([[
hi FocusedSymbol guibg=]] .. colors.green .. [[

augroup ft_outline
  au!

  au Filetype outline setlocal nolist
augroup end
]])
end

vim.g.symbols_outline = {
  auto_preview = false,
  relative_width = true,
  width = 65,
  preview_bg_highlight = "bg",
}

return {
  setup = function(use)
    use {
      "simrat39/symbols-outline.nvim",
      after = "which-key.nvim",
      config = config,
    }
  end,
}
