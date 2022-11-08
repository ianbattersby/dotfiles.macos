local function config()
  require("notify").setup {
    stages = "static",
    render = "minimal",
  }

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
    presets = {
      lsp_doc_border = true,
      bottom_search = true,
    },
  }

  vim.keymap.set({ "n", "i" }, "<C-Bslash>", function()
    require("noice").cmd "last"
  end, { silent = true, noremap = true, desc = "Last message" })

  vim.keymap.set({ "n", "i" }, "<C-]>", function()
    require("noice").cmd "telescope"
  end, { silent = true, noremap = true, desc = "Message history" })
end

return {
  setup = function(use)
    use {
      "folke/noice.nvim",
      --event = "VimEnter",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = config,
    }
  end,
}
