local function config()
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

      if language then
        if language.initialize ~= nil then
          language.initialize()
        end

        local language_config = vim.tbl_deep_extend("force", cmp_enhanced_config, language.config)

        if language_config.on_attach == nil then
          local lconfig = require("lspbuilder").new()
          language_config.on_attach = lconfig:on_attach()
        end

        lspconfig[language.server].setup(language_config)

        if language.finalize ~= nil then
          language.finalize()
        end
      end
    end
  end

  lspstatus.register_progress()

  setup_servers()

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  -- This is overrided by lsp_signature (and by noice.nvim)
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = "single",
  -- })

  -- require("lsp_signature").setup {
  --   bind = true,
  --   doc_lines = 10,
  --   floating_window = true,
  --   floating_window_off_y = -2,
  --   fix_pos = false,
  --   hint_enable = true,
  --   hint_prefix = " ",
  --   hint_scheme = "String",
  --   hi_parameter = "Search",
  --   max_height = 22,
  --   max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  --   handler_opts = {
  --     border = "single", -- double, rounded, single, shadow, none
  --   },
  --   zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  --   padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
  -- }
end

return {
  setup = function(use)
    use {
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "nvim-lua/lsp-status.nvim",
        --"ray-x/lsp_signature.nvim",
      },
      after = { "rust-tools.nvim", "nvim-cmp", "lsp-status.nvim" },
      config = config,
    }
  end,
}
