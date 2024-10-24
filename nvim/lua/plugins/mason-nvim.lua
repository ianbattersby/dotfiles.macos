local M = {

  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "bash-language-server",
      "codelldb",
      -- "csharp-language-server",
      "css-lsp cssls",
      "dockerfile-language-server",
      "eslint-lsp eslint",
      "gopls",
      "hclfmt",
      "json-lsp",
      "lua-language-server",
      "marksman",
      "markdownlint",
      -- "netcoredbg",
      "omnisharp",
      "pyright",
      "ruff-lsp",
      "rust-analyzer",
      "shellcheck",
      "shfmt",
      "stylua",
      "terraform-ls",
      "tflint",
      "typescript-language-server",
      "vim-language-server",
      "xmlformatter",
      "yamlfmt",
      "yaml-language-server"
    },
  },
}

return M
