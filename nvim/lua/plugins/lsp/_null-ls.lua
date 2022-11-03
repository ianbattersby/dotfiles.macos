local function config()
  local null_ls = require "null-ls"

  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.markdownlint,
    },
  }
end

return {
  setup = function(use)
    use {
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "neovim/nvim-lspconfig" },
      },
      after = "nvim-lspconfig",
      config = config,
    }
  end,
}
