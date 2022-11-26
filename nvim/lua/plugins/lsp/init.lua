return {
  setup = function(use)
    require("plugins.lsp._neodev-vim").setup(use)
    require("plugins.lsp._rust-tools").setup(use)
    require("plugins.lsp._lspconfig").setup(use)
    require("plugins.lsp._null-ls").setup(use)
    require("plugins.lsp._nvim-cmp").setup(use)
    require("plugins.lsp._nvim-dap").setup(use)
    require("plugins.lsp._nvim-navic").setup(use)
    require("plugins.lsp._treesitter").setup(use)
    require("plugins.lsp._trouble").setup(use)
    require("plugins.lsp._nvim-neotest").setup(use)
    require("plugins.lsp._lsp-inlayhints").setup(use)
    require("plugins.lsp._codelens-extensions").setup(use)
    --require("plugins.lsp._copilot-vim").setup(use)
    require("plugins.lsp._neogen").setup(use)
    require("plugins.lsp._symbols-outline").setup(use)
  end,
}
