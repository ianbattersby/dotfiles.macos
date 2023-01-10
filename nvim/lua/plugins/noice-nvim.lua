local M = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    "ianbattersby/telescope.nvim",
  },
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true,
      desc = "Scroll forward" },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true,
      desc = "Scroll backward" },
    { "<C-]>", function()
      if vim.api.nvim_buf_get_option(0, "filetype") == "noice" then
        vim.cmd "q"
      else
        require("noice").cmd "last"
      end
    end, mode = { "i", "n" }, desc = "Last message" },

  },
}

function M.config()
  require("noice").setup {
    views = {
      notify = {
        render = "minimal",
      },
    },
    messages = {
      enabled = true,
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
  require("telescope").load_extension "noice"
end

return M
