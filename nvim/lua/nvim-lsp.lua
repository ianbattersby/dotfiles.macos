local lspconfig = require'lspconfig'

lspconfig.gopls.setup{}
lspconfig.tsserver.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.pyright.setup{}
lspconfig.yamlls.setup{}
lspconfig.cssls.setup{}
lspconfig.bashls.setup{}
lspconfig.vimls.setup{}

-- Let's use terraform-lsp from juliosueiras
lspconfig.terraformls.setup{
  cmd = { "terraform-lsp" }
}

-- lspconfig.rust_analyzer.setup{
--     cmd = { "rust-analyzer" }
--     filetypes = { "rust" }
--     root_dir = root_pattern("Cargo.toml", "rust-project.json")
--     settings = {
--       ["rust-analyzer"] = {}
--     }
-- }
