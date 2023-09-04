local M = {
  "neovim/nvim-lspconfig",
  -- name = "lsp",
  event = "BufReadPre",
  version = false,
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "simrat39/rust-tools.nvim",
    {
      name = "lsp_lines",
      url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      version = false,
      event = "BufReadPre",
    }
  },
}

function M.config()
  require "mason".setup { ui = { border = "rounded" } }
  require "mason-lspconfig".setup { automatic_installation = true }
  require "plugins.lsp.servers".setup()
  require "plugins.lsp.diagnostics".setup()
  require "lsp_lines".setup()
end

return M
