return {
  "ianbattersby/telescope.nvim",
  dependencies = {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    opts = function()
      local config = require "config.options"
      local icons = vim.deepcopy(config.icons.kinds)

      -- HACK: fix lua's weird choice for `Package` for control
      -- structures like if/else/for/etc.
      icons.lua = { Package = icons.Control }

      ---@type table<string, string[]>|false
      local filter_kind = false
      if config.kind_filter then
        filter_kind = assert(vim.deepcopy(config.kind_filter))
        filter_kind._ = filter_kind.default
        filter_kind.default = nil
      end

      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        layout = {
          resize_to_content = false,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        icons = icons,
        filter_kind = filter_kind,
        -- stylua: ignore
        guides = {
          mid_item = "├╴",
          last_item = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        }
      }
      return opts
    end,
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
  },
  opts = function()
    require "telescope".load_extension "aerial"
  end,
  keys = {
    {
      "<leader>ss",
      "<cmd>Telescope aerial<cr>",
      desc = "Goto Symbol (Aerial)",
    },
  },
}
