local M = {
  "phaazon/mind.nvim",
  branch = "v2.2",
  cmd = { "MindOpenMain", "MindOpenClose", "MindOpenProject", "MindOpenSmartProject" },
  keys = {
    { "<leader>mo", desc = "Open" },
    { "<leader>mq", desc = "Close" },
    { "<leader>mp", desc = "Project" },
    { "<leader>ms", desc = "Smart Project" },
  },
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  require("mind").setup {}

  vim.keymap.set("n", "<leader>mo", "<CMD>MindOpenMain<CR>", { noremap = true, silent = true, desc = "Open" })
  vim.keymap.set("n", "<leader>mq", "<CMD>MindOpenClose<CR>", { noremap = true, silent = true, desc = "Close" })
  vim.keymap.set("n", "<leader>mp", "<CMD>MindOpenProject<CR>", { noremap = true, silent = true, desc = "Project" })
  vim.keymap.set(
    "n",
    "<leader>ms",
    "<CMD>MindOpenSmartProject<CR>",
    { noremap = true, silent = true, desc = "Smart Project" }
  )
  vim.keymap.set("n", "<leader>mr", "<CMD>MindReloadState<CR>", { noremap = true, silent = true, desc = "Reload" })
end

return M
