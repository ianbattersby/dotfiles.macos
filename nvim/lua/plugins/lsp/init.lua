return {
  setup = function(use)
    require 'plugins.lsp.nvim-cmp'.setup(use)
    require 'plugins.lsp.lspconfig'.setup(use)
    --require 'plugins.lsp.lspsaga'.setup(use)
    require 'plugins.lsp.lsputils'.setup(use)
    require 'plugins.lsp.trouble'.setup(use)
    require 'plugins.lsp.treesitter'.setup(use)
    require 'plugins.lsp.nvim-dap'.setup(use)
  end
}
