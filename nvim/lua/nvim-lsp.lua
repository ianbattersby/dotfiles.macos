local lspconfig = require'lspconfig'

lspconfig.gopls.setup{}
lspconfig.tsserver.setup{}
--lspconfig.rust_analyzer.setup{}
lspconfig.pyright.setup{}
lspconfig.yamlls.setup{}
lspconfig.cssls.setup{}
lspconfig.bashls.setup{}
lspconfig.vimls.setup{}

-- Let's use terraform-lsp from juliosueiras
lspconfig.terraformls.setup{
  cmd = { "terraform-lsp" }
}

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
lspconfig.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- lspconfig.rust_analyzer.setup{
--     cmd = { "rust-analyzer" }
--     filetypes = { "rust" }
--     root_dir = root_pattern("Cargo.toml", "rust-project.json")
--     settings = {
--       ["rust-analyzer"] = {}
--     }
-- }
