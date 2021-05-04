return {
  setup = function(use)
    require 'plugins.lsp.lspconfig'.setup(use)
    require 'plugins.lsp.nvim-compe'.setup(use)
    require 'plugins.lsp.lspsaga'.setup(use)
    require 'plugins.lsp.treesitter'.setup(use)
  end
}
