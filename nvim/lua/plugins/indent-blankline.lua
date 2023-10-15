local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
      config = function()
        local rainbow_delimiters = require "rainbow-delimiters"

        vim.g.rainbow_delimiters = {
          strategy = {
            [""] = rainbow_delimiters.strategy["global"],
            vim = rainbow_delimiters.strategy["local"],
          },
          query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
          },
          highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
          },
        }
      end
    },
  },
}

function M.config()
  vim.opt.list = true
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "tab:⋅→"
  vim.opt.listchars:append "eol:↴"

  require "ibl".setup {
    exclude = {
      buftypes = { "terminal", "telescope", "nofile", "packer", "lazy" },
      filetypes = {
        "help",
        "alpha",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "TelescopePrompt",
        "toggleterm",
        "Outline",
        "neotest-summary",
      }
    },
    -- use_treesitter = true,
    -- colored_indent_levels = true,
    -- char_highlight_list = { "VertSplit" },
    scope = {
      enabled = true,
      show_start = false,
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterBlue",
        "RainbowDelimiterCyan",
        "RainbowDelimiterViolet",
      }
    }
  }

  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
