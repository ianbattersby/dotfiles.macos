local function config()
  require("focus").setup {
    excluded_buftypes = { "nofile", "prompt", "popup" },
    cursorline = false,
    signcolumn = false,
  }

  require("which-key").register({
    s = {
      name = "Split",
      n = { ":FocusSplitNicely<CR>", "Nicely" },
      c = { ":FocusSplitCycle<CR>", "Cycle" },
      l = { ":FocusSplitLeft<CR>", "Left" },
      u = { ":FocusSplitUp<CR>", "Up" },
      r = { ":FocusSplitRight<CR>", "Right" },
      d = { ":FocusSplitDown<CR>", "Down" },
      m = { ":FocusMaximise<CR>", "Maximise" },
      e = { ":FocusEqual<CR>", "Equalize" },
      x = { ":FocusMaxOrEqual<CR>", "Balance" },
    },
    h = { ":FocusSplitLeft<CR>", "Split Left" },
    j = { ":FocusSplitDown<CR>", "Split Down" },
    k = { ":FocusSplitUp<CR>", "Split Up" },
    l = { ":FocusSplitRight<CR>", "Split Right" },
    x = { ":bd<CR>", "Close Buffer" },
  }, { prefix = "<leader>" })
end

return {
  setup = function(use)
    use {
      "beauwilliams/focus.nvim",
      after = "which-key.nvim",
      config = config,
    }
  end,
}
