local M = {

  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "bash-language-server",
      "codelldb",
      "css-lsp cssls",
      "dockerfile-language-server",
      "eslint-lsp eslint",
      "gopls",
      "json-lsp",
      "lua-language-server",
      "markdownlint",
      "omnisharp",
      "pyright",
      "ruff-lsp ruff_lsp",
      "rust-analyzer",
      "shellcheck",
      "shfmt",
      "terraform-ls",
      "typescript-language-server",
      "vim-language-server",
      "xmlformatter",
      "yaml-language-server"
    },
  },
}

return M
