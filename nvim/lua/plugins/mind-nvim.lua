local M = {
  "phaazon/mind.nvim",
  branch = "v2.2",
  cmd = { "MindOpenMain", "MindOpenClose", "MindOpenProject", "MindOpenSmartProject" },
  keys = {
    { "<leader>mo", "<CMD>MindOpenMain<CR>", desc = "Open" },
    { "<leader>mq", "<CMD>MindOpenClose<CR>", desc = "Close" },
    { "<leader>mp", "<CMD>MindOpenProject<CR>", desc = "Project" },
    { "<leader>ms", "<CMD>MindOpenSmartProject<CR>", desc = "Smart Project" },
    { "<leader>mr", "<CMD>MindReloadState<CR>", desc = "Reload" },
  },
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  require("mind").setup {}
end

return M
