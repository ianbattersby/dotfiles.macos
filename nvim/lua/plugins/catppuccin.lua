local M = {
  "catppuccin/nvim",
  name = "catppuccin",
}

function M.config()
  local settings = {}
  local integrations = {}
  local dap_integration = {}
  local navic_integration = {}

  integrations.gitsigns = true
  integrations.lsp_trouble = true
  integrations.mason = true
  integrations.mini = true
  integrations.neotest = true
  integrations.neotree = true
  integrations.noice = true
  integrations.notify = true
  integrations.symbols_outline = true
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

  require("catppuccin").setup(settings)

  vim.cmd [[colorscheme catppuccin]]
end

return M
