local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  version = false,
}

function M.config()
  local settings = {}
  local integrations = {}
  local dap_integration = {}
  local navic_integration = {}

  integrations.alpha = true
  integrations.cmp = true
  integrations.flash = true
  integrations.gitsigns = true
  integrations.indent_blankline = { enabled = true }
  integrations.lsp_trouble = true
  integrations.mason = true
  integrations.mini = true
  integrations.neotest = true
  integrations.neotree = true
  integrations.native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        }
  integrations.navic = { enabled = true, custom_bg = "lualine" }
  integrations.neotest = true
  integrations.neotree = true
  integrations.noice = true
  integrations.notify = true
  integrations.semantic_tokens = true
  integrations.telescope = true
  integrations.treesitter = true
  integrations.treesitter_context = true
  integrations.which_key = true

  dap_integration.enabled = true
  dap_integration.enable_ui = true

  navic_integration.enabled = true
  navic_integration.custom_bg = "NONE"

  integrations.navic = navic_integration
  integrations.dap = dap_integration

  settings.integrations = integrations
  settings.term_colors = true
  settings.transparent_background = false

  require "catppuccin".setup(settings)

  vim.cmd [[colorscheme catppuccin]]
end

return M
