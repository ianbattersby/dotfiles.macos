local function config()
  require("noice").setup {
    messages = {
      enabled = true,
      view = "mini",
      view_error = "split",
      view_warn = "mini",
      view_history = "split",
      view_search = "virtualtext",
    },
    notify = {
      enabled = true,
    },
    hacks = {
      slip_duplicate_messages = true,
    },
    lsp = {
      progress = {
        enabled = true,
      },
      hover = {
        enabled = true,
      },
    },
    format = {
      default = "{message}",
    },
  }
end

return {
  setup = function(use)
    use {
      "folke/noice.nvim",
      event = "VimEnter",
      requires = {
        "MunifTanjim/nui.nvim",
        --"rcarriga/nvim-notify",
      },
      config = config,
    }
  end,
}
