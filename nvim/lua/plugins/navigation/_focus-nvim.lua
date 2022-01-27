local function config()
  require("focus").setup()

  vim.api.nvim_set_keymap("n", "<leader>fsn", ":FocusSplitNicely<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fsc", ":FocusSplitCycle<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fsl", ":FocusSplitLeft<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fsu", ":FocusSplitUp<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fsr", ":FocusSplitRight<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fsd", ":FocusSplitDown<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fm", ":FocusMaximize<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fe", ":FocusEqual<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fx", ":FocusMaxOrEqual<CR>", { silent = true })

  vim.api.nvim_set_keymap("n", "<leader>h", ":FocusSplitLeft<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>j", ":FocusSplitDown<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>k", ":FocusSplitUp<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>l", ":FocusSplitRight<CR>", { silent = true })

  vim.api.nvim_set_keymap("n", "<leader>x", ":q<CR>", { silent = true })
end

return {
  setup = function(use)
    use {
      "beauwilliams/focus.nvim",
      config = config,
    }
  end,
}
