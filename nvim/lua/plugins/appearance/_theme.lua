local name = "catppuccin"

local function config()
  vim.g.catppuccin_flavour = "frappe"

  require("catppuccin").setup {
    term_colors = true,
    transparent_background = false,
    integrations = {
      gitsigns = true,
      neotree = true,
      notify = true,
      treesitter = true,
      treesitter_context = true,
      symbols_outline = true,
      telescope = true,
      lsp_trouble = true,
      which_key = true,
      neotest = true,
      mini = true,
      noice = true,
      mason = true,
      dap = {
        enabled = true,
        enable_ui = true, -- enable nvim-dap-ui
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      navic = {
        enabled = false,
        custom_bg = "NONE",
      },
    },
  }

  vim.cmd [[colorscheme catppuccin]]
end

return {
  name = name,
  setup = function(use)
    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = config,
    }
  end,
}
