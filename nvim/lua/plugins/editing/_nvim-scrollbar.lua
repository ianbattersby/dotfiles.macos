local function config()
  local theme = require("plugins.appearance._theme").name
  local colors = require(theme .. ".colors").setup()

  require("scrollbar").setup {
    handle = {
      color = colors.bg_highlight,
    },
    marks = {
      Search = { color = colors.orange },
      Error = { color = colors.error },
      Warn = { color = colors.warning },
      Info = { color = colors.info },
      Hint = { color = colors.hint },
      Misc = { color = colors.purple },
    },
    handlers = {
      diagnostic = true,
      search = true,
    },
  }
end

return {
  setup = function(use)
    use {
      "petertriho/nvim-scrollbar",
      after = "onedark.nvim",
      config = config,
    }
  end,
}
