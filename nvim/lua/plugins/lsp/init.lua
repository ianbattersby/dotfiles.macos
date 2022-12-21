local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/lsp-status.nvim",
    "simrat39/rust-tools.nvim",
  },
}

function M.config()
  local lspconfig = require "lspconfig"
  local languages = require "languages"
  local lspstatus = require "lsp-status"

  require("mason").setup { ui = { border = "single" } }
  require("mason-lspconfig").setup { automatic_installation = true }

  local function setup_servers()
    for _, language_impl in pairs(vim.tbl_keys(languages)) do
      local language = languages[language_impl]

      local cmp_enhanced_config = vim.tbl_deep_extend(
        "force",
        lspconfig[language.server] or {},
        { capabilities = require("cmp_nvim_lsp").default_capabilities() }
      )

      if language ~= nil then
        if language.initialize ~= nil then
          language.initialize()
        end
        local language_config = type(language.config) == "function" and language.config() or language.config
        local combined_config = vim.tbl_deep_extend("force", cmp_enhanced_config, language_config)

        if combined_config.on_attach == nil then
          local lconfig = require("lspbuilder").new()
          combined_config.on_attach = lconfig:on_attach()
        end

        lspconfig[language.server].setup(combined_config)

        if language.finalize ~= nil then
          language.finalize()
        end
      end
    end
  end

  lspstatus.register_progress()

  setup_servers()

  local diagnostic_config = {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    virtual_lines = { only_current_line = true },
  }

  vim.diagnostic.config(diagnostic_config)

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config)

  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --   border = "single",
  -- })
end

return M
