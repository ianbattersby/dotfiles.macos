local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/lsp-status.nvim",
    "simrat39/rust-tools.nvim",
  },
}

function M.config()
  require("mason").setup { ui = { border = "rounded" } }
  require("mason-lspconfig").setup { automatic_installation = true }
  require("plugins.lsp.servers").setup()
  require("plugins.lsp.diagnostics").setup()
end

return M
