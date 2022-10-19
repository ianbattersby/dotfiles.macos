local function config()
  require("focus").setup {
    excluded_buftypes = {
      "nofile",
      "prompt",
      "popup",
    },
    excluded_filetypes = {
      "DiffviewFiles",
      "DiffviewFileHistory",
      "DiffviewFilePanel",
      "fterm",
      "term",
      "toggleterm",
      "Trouble",
    },
    cursorline = false,
    signcolumn = false,
  }

  vim.keymap.set("n", "<leader>sn", "<CMD>FocusSplitNicely<CR>", { noremap = true, silent = true, desc = "Nicely" })
  vim.keymap.set("n", "<leader>sc", "<CMD>FocusSplitCycle<CR>", { noremap = true, silent = true, desc = "Cycle" })
  vim.keymap.set("n", "<leader>sl", "<CMD>FocusSplitLeft<CR>", { noremap = true, silent = true, desc = "Left" })
  vim.keymap.set("n", "<leader>su", "<CMD>FocusSplitUp<CR>", { noremap = true, silent = true, desc = "Up" })
  vim.keymap.set("n", "<leader>sr", "<CMD>FocusSplitRight<CR>", { noremap = true, silent = true, desc = "Right" })
  vim.keymap.set("n", "<leader>sd", "<CMD>FocusSplitDown<CR>", { noremap = true, silent = true, desc = "Down" })
  vim.keymap.set("n", "<leader>sm", "<CMD>FocusMaximise<CR>", { noremap = true, silent = true, desc = "Maximise" })
  vim.keymap.set("n", "<leader>se", "<CMD>FocusEqual<CR>", { noremap = true, silent = true, desc = "Equalize" })
  vim.keymap.set("n", "<leader>sx", "<CMD>FocusMaxOrEqual<CR>", { noremap = true, silent = true, desc = "Balance" })
  vim.keymap.set("n", "<leader>h", "<CMD>FocusSplitLeft<CR>", { noremap = true, silent = true, desc = "Split Left" })
  vim.keymap.set("n", "<leader>j", "<CMD>FocusSplitDown<CR>", { noremap = true, silent = true, desc = "Split Down" })
  vim.keymap.set("n", "<leader>k", "<CMD>FocusSplitUp<CR>", { noremap = true, silent = true, desc = "Split Up" })
  vim.keymap.set("n", "<leader>l", "<CMD>FocusSplitRight<CR>", { noremap = true, silent = true, desc = "Split Right" })
  vim.keymap.set("n", "<leader>x", "<CMD>bd<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
end

return {
  setup = function(use)
    use {
      "beauwilliams/focus.nvim",
      config = config,
    }
  end,
}
