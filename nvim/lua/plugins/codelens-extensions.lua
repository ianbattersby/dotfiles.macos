local M = {
  "ericpubu/lsp_codelens_extensions.nvim",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  },
  event = "VeryLazy",
}

function M.config()
  require "codelens_extensions" .setup {
    vertical_split = false,
    rust_debug_adapter = "rt_lldb",
    init_rust_commands = true,
  }
end

return M
