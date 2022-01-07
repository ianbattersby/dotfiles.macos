local function config()
  require("trouble").setup {
    position = "bottom",
    height = 10,
    auto_open = false,
    auto_close = true,
  }

  vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>xw",
    "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
  )
  -- vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {
  --   silent = true,
  --   noremap = true,
  -- })
  --vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
  --vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
end

return {
  setup = function(use)
    use {
      "folke/trouble.nvim",
      requires = {
        { "kyazdani42/nvim-web-devicons" },
      },
      config = config,
    }
  end,
}
