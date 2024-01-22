local M = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      keys = {
        {
          "<leader>un",
          function()
            require "notify".dismiss({ silent = true, pending = true })
          end,
          desc = "Dismiss All Notifications",
        },
      },
      opts = {
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      },
    },
    "ianbattersby/telescope.nvim",
  },
  keys = {
    { "<S-Enter>", function() require "noice".redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require "noice".cmd "last" end, desc = "Noice Last Message" },
    { "<leader>snh", function() require "noice".cmd "history" end, desc = "Noice History" },
    { "<leader>sna", function() require "noice".cmd "all" end, desc = "Noice All" },
    { "<leader>snd", function() require "noice".cmd "dismiss" end, desc = "Dismiss All" },
    {
      "<c-f>",
      function() if not require "noice.lsp".scroll(4) then return "<c-f>" end end,
      silent = true,
      expr = true,
      desc = "Scroll forward",
      mode = { "i", "n", "s" }
    },
    {
      "<c-b>",
      function() if not require "noice.lsp".scroll(-4) then return "<c-b>" end end,
      silent = true,
      expr = true,
      desc = "Scroll backward",
      mode = { "i", "n", "s" }
    },
  },
}

function M.config()
  require "noice".setup {
    views = {
      notify = {
        render = "minimal",
      },
    },
    messages = {
      enabled = false,
      -- view = "popup",
      -- view_error = "split",
      -- view_warn = "mini",
      -- view_history = "split",
      -- view_search = "virtualtext",
    },
    notify = {
      enabled = true,
      view = "notify",
    },
    commands = {
      last = { view = "split" },
      errors = { view = "split" },
    },
    lsp = {
      progress = { enabled = false },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      lsp_doc_border = true,
      bottom_search = true,
    },
  }

  -- Load Telescope extension
  require "telescope".load_extension "noice"
end

return M
